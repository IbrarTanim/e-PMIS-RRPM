import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatefulWidget {
  final String pdfUrl;
  final String token; // Bearer token for authentication

  const PDFViewerScreen({
    Key? key,
    required this.pdfUrl,
    required this.token,
  }) : super(key: key);

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  File? pdfFile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    downloadPdf();
  }

  Future<void> downloadPdf() async {
    try {
      final dir = await getTemporaryDirectory();
      final filePath = "${dir.path}/temp.pdf";

      debugPrint("Downloading PDF from: ${widget.pdfUrl}");

      await Dio().download(
        widget.pdfUrl,
        filePath,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${widget.token}',
          },
        ),
      );

      debugPrint("PDF saved to: $filePath");

      setState(() {
        pdfFile = File(filePath);
        loading = false;
      });
    } catch (e) {
      debugPrint("PDF download error: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(title: "PDF Viewer"),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : pdfFile != null
              ? SfPdfViewer.file(pdfFile!)
              : const Center(child: Text("Failed to load PDF")),
    );
  }
}
