import 'package:camera/camera.dart';
import 'package:chat/services/vin_scanner_service.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
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

      final inputImage = InputImage.fromBytes(
        bytes: image.planes[0].bytes,
        inputImageData: InputImageData(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          imageRotation: InputImageRotation.rotation0deg,
          inputImageFormat: InputImageFormat.nv21,
          planeData: image.planes
              .map(
                (p) => InputImagePlaneMetadata(
                  bytesPerRow: p.bytesPerRow,
                  height: p.height,
                  width: p.width,
                ),
              )
              .toList(),
        ),
      );

      final result = await _textRecognizer.processImage(inputImage);
      final texto = result.text;

      Provider.of<VinScannerService>(
        context,
        listen: false,
      ).procesarTextoDetectado(texto);
      _isDetecting = false;
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
      appBar: AppBar( title: const Text("Escanear VIN")),
      body: Column(
        children: [
          if(_cameraController.value.isInitialized)
            AspectRatio(
              aspectRatio: _cameraController.value.aspectRatio,
              child: CameraPreview(_cameraController),
            )
          else
            const Center( child: CircularProgressIndicator()),

          const SizedBox(height: 10),
          Text(vin != null ? "VIN detectado: $vin" : "Escaneando..."),
          const SizedBox(height: 10),
          if( vin != null )
            ElevatedButton(
              onPressed: (){
                print("VIN confirmado: $vin");
              },
              child: const Text("Confirmar VIN"),
            ),          
        ],
      ),
    );
  }
}
