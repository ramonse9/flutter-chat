import 'package:camera/camera.dart';
import 'package:chat/services/vin_scanner_service.dart';
import 'package:flutter/material.dart';
//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:provider/provider.dart';

class EscanearVinPage extends StatefulWidget {
  const EscanearVinPage({super.key});

  @override
  State<EscanearVinPage> createState() => _EscanearVinPageState();
}

class _EscanearVinPageState extends State<EscanearVinPage> {
  late CameraController _cameraController;
  late TextRecognizer _textRecognizer;
  bool _isDetecting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCamera();
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
    );

    _cameraController = CameraController(backCamera, ResolutionPreset.medium);
    await _cameraController.initialize();

    _cameraController.startImageStream((image) async {
      if (_isDetecting) return;
      _isDetecting = true;

      try {
        final inputImage = InputImage.fromBytes(
          bytes: image.planes[0].bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: InputImageRotation.rotation0deg,
            format: InputImageFormat.nv21,
            bytesPerRow: image.planes[0].bytesPerRow,
          ),
        );

        final recognizedText = await _textRecognizer.processImage(inputImage);
        Provider.of<VinScannerService>(
          context,
          listen: false,
        ).procesarTextoDetectado(recognizedText.text);
      } catch (e) {
        debugPrint("Error procesado imagen: $e");
      } finally {
        _isDetecting = false;
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cameraController.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vin = context.watch<VinScannerService>().vinDetectado;

    return Scaffold(
      appBar: AppBar(title: const Text("Escanear VIN")),
      body: Column(
        children: [
          if (_cameraController.value.isInitialized)
            AspectRatio(
              aspectRatio: _cameraController.value.aspectRatio,
              child: CameraPreview(_cameraController),
            )
          else
            const Center(child: CircularProgressIndicator()),

          const SizedBox(height: 10),
          Text(vin != null ? "VIN detectado: $vin" : "Escaneando..."),
          const SizedBox(height: 10),
          if (vin != null)
            ElevatedButton(
              onPressed: () {
                //Buscar órdenes por VIN
                debugPrint("VIN confirmado: $vin");
              },
              child: const Text("Confirmar VIN"),
            ),
        ],
      ),
    );
  }
}
