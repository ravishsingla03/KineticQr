import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQr extends StatefulWidget {
  const ScanQr({super.key});

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: const Text('Scan Qr Code')),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
                returnImage: true,
              ),
              onDetect: (capture) {
                List<Barcode> codes = capture.barcodes;
                for (Barcode code in codes) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Barcode Detected',
                              style: TextStyle(color: Colors.blueGrey)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              code.type == BarcodeType.url
                                  ? GestureDetector(
                                      onTap: () async {
                                        final url =
                                            Uri.parse(code.rawValue.toString());
                                        try {
                                          await launchUrl(url);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Text(code.rawValue.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black)),
                                    )
                                  : Text(code.rawValue.toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15)),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                codes.clear();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      });
                }
              },
            ),
          ),
        ));
  }
}
