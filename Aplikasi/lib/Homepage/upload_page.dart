import 'package:flutter/material.dart';
import 'package:aplikasi/services/imagepicker_service.dart';
import 'package:aplikasi/services/cloudinaryservice.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  void uploadAndSave(BuildContext context) async {
    final image = await ImagePickerService.pickImage();
    if (image == null) return;

    final url = await CloudinaryService.uploadImageToCloudinary(image);
    if (url != null) {
      await CloudinaryService.saveImageUrlToFirestore(url);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gambar berhasil diupload!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Gambar")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => uploadAndSave(context),
          child: Text("Upload Gambar"),
        ),
      ),
    );
  }
}
