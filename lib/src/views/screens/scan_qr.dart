import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myapp/core/themes/colors.dart';
import 'package:myapp/services/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
class ScanQR extends StatelessWidget {
  const ScanQR({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor09,
        centerTitle: true,
        title: Text('Scan QR',style: TextStyle(color : AppColors.primaryColor10),),
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          child: MobileScanner(onDetect: (capture) async{
            final Barcode barcode = capture.barcodes.first;
            print(barcode.rawValue ?? "No Data found in QR");
            context.pushNamed(RouteNames.scannedCodeData,extra:barcode.rawValue);
            await launchUrl(Uri.parse(barcode.rawValue.toString()),mode: LaunchMode.externalApplication);
          }),
        ),
      ),
    );
  }
}
