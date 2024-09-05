import 'package:flutter/material.dart';
import 'scanCode.dart';
import 'generateCode.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Kinetic QR')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScanQr()));
                },
                child: Text('Scan Qr Code')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GenerateCode()));
                },
                child: Text('Generate Qr Code')),
          ],
        ),
      ),
    );
  }
}
