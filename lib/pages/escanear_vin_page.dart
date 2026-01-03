import 'dart:io';

import 'package:camera/camera.dart';
import 'package:chat/services/vin_scanner_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:provider/provider.dart';

class EscanearVinPage extends StatefulWidget {
  const EscanearVinPage({super.key});

  @override
  State<EscanearVinPage> createState() => _EscanearVinPageState();
}

class _EscanearVinPageState extends State<EscanearVinPage> {
  CameraController? _cameraController;
  late TextRecognizer _textRecognizer;
  bool _isDetecting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    _textRecognizer = TextRecognizer();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty){
      debugPrint("No hay cámaras disponibles en este dispositivo/emulador");
      return;
    }

    final backCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
    );

    _cameraController = CameraController(
      backCamera, 
      ResolutionPreset.high, 
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid 
          ? ImageFormatGroup.yuv420 
          : ImageFormatGroup.bgra8888,
    );
    await _cameraController!.initialize();

    await _cameraController!.lockCaptureOrientation(DeviceOrientation.portraitUp);
    await _cameraController!.setFocusMode(FocusMode.auto);

    _cameraController!.startImageStream((image) async {
      if (_isDetecting) return;
      _isDetecting = true;

      try {

        //final bytes = image.planes[0].bytes;
        final WriteBuffer allBytes = WriteBuffer();
        for (final Plane plane in image.planes) {
          allBytes.putUint8List(plane.bytes);
        }
        final bytes = allBytes.done().buffer.asUint8List();

        final rotation = _getImageRotation( backCamera.sensorOrientation );

        final inputImage = InputImage.fromBytes(
          bytes: bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: rotation,
            format: Platform.isAndroid 
              ? InputImageFormat.nv21 
              : InputImageFormat.bgra8888,
            //format: InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.yuv420,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        final recognizedText = await _textRecognizer.processImage(inputImage);
        if( recognizedText.text.isNotEmpty){
          print("TEXTO+");
          print("TEXTO+++");
          print("TEXTO++++++");
          print("TEXTO+++++++++");
          print("TEXTO++++++++++++");
          print("TEXTO++++++++++++++");
          print("TEXTO+--");
          
          debugPrint("Texto detectado: ${recognizedText.text}");

          // Limpieza rápida para el VIN
          final cleanVin = recognizedText.text.replaceAll(RegExp(r'[^A-Z0-9]'), '');
          
          Provider.of<VinScannerService>(
            context,
            listen: false,
          ).procesarTextoDetectado(cleanVin);

        }


      } catch (e) {
        debugPrint("Error procesado imagen: $e");
      } finally {
        await Future.delayed( const Duration(milliseconds: 2000));
        _isDetecting = false;
      }
    });

    if( mounted ) setState(() {});
  }

  InputImageRotation _getImageRotation( int sensorOrientation){
    switch(sensorOrientation){
      case 0:
        return InputImageRotation.rotation0deg;
      case 90: 
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default: 
        return InputImageRotation.rotation0deg;
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    // TODO: implement dispose
    _cameraController?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_cameraController == null || !_cameraController!.value.isInitialized){
      return const Scaffold(body: Center( child: CircularProgressIndicator()));
    }
    var size = MediaQuery.of(context).size;
    var deviceRatio = size.width / size.height;

    double cameraRatio = _cameraController!.value.aspectRatio;

    final vin = context.watch<VinScannerService>().vinDetectado;

    return Scaffold(
      appBar: AppBar(title: const Text("Escanear VIN")),
      body: Stack(
        children: [
          // 1 La camara ocupa toda la pantalla 
          SizedBox.expand(
            child: CameraPreview(_cameraController!),
          ),
          //  El overlay (mascara de recorte)
          _buildOverlay(context),
          // 3 UI superior - boton de volver
          Positioned(
            top: 40, 
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // 4 Resultado del VIN 
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                context.watch<VinScannerService>().vinDetectado ?? "Buscando VIN...",
                style: const TextStyle( color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget _buildOverlay(BuildContext context){
    return Stack(
      children: [
        //Fondo oscuro con recorte
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withValues( alpha: 0.7),// .withOpacity(0.7),
            BlendMode.srcOut
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              //Cuando el usuario gire el celular, este hueco quedara horizontal
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ]
          )
        ),
        //Borde del área de escaneo
        Align(
          alignment: Alignment.center,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        //Texto rotado para indicar que gire el móvil
        /*
        Center(
          child: RotatedBox(
            quarterTurns: 1,
            child: const Text(
              "Gire el teléfono y alinee el VIN aquí",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),*/
      ]
    );
  }
}
