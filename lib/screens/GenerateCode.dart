import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share/share.dart';

class GenerateCode extends StatefulWidget {
  const GenerateCode({super.key});

  @override
  State<GenerateCode> createState() => _GenerateCodeState();
}

class _GenerateCodeState extends State<GenerateCode> {
  String code = '';
  final ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: const Text('Generate Qr Code')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      code = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter any URL, text, etc.',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final Uint8List? image = await screenshotController.capture();

                  if (image != null) {
                    final direc = await getApplicationDocumentsDirectory();

                    final File file = File('${direc.path}/qr.png');
                    await file.writeAsBytes(image);
                    Share.shareFiles([file.path]);
                  }
                },
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: code.isNotEmpty
                        ? PrettyQrView.data(
                            data: code,
                          )
                        : null,
                  ),
                ),
              ),
              Container(
                child: code.isNotEmpty ? Text("Tap QrCode to share it") : null,
              )
            ],
          ),
        ));
  }
}
