import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:spray/core/widgets/back_button.dart';

@RoutePage()
class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      returnImage: true,
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> onDetectQR(String data) async {
    controller.stop();
    context.router.pop(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const CustomBackButton(invert: true),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: double.infinity,
                height: 420,
                child: MobileScanner(
                  controller: controller,
                  onDetectError: (e, _) {
                    controller.stop();
                  },
                  onDetect: (capture) {
                    if (capture.barcodes.isEmpty) {
                      debugPrint("Bar codes are empty");
                      return;
                    }
              
                    for (final barcode in capture.barcodes) {
                      String? data = barcode.rawValue;
              
                      if (data != null && data.isNotEmpty) {
                        onDetectQR(data);
                        break;
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
