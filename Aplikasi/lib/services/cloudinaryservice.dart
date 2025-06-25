import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudinaryService {
  /// Ganti dengan nama Cloudinary kamu
  static const String cloudName = "dprfhy79n";

  /// Buat upload preset dari dashboard Cloudinary (unsigned)
  static const String uploadPreset = "flutter_unsigned";

  /// Upload gambar ke Cloudinary, lalu kembalikan URL-nya
  static Future<String?> uploadImageToCloudinary(File imageFile) async {
    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/dprfhy79n/image/upload",
    );

    try {
      final request =
          http.MultipartRequest('POST', url)
            ..fields['upload_preset'] = uploadPreset
            ..files.add(
              await http.MultipartFile.fromPath('file', imageFile.path),
            );

      final response = await request.send();
      final resStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = jsonDecode(resStr);
        return data['secure_url'];
      } else {
        print("Upload failed: $resStr");
        return null;
      }
    } catch (e) {
      print("Error uploading to Cloudinary: $e");
      return null;
    }
  }

  /// Simpan URL gambar yang sudah diupload ke Firestore
  static Future<void> saveImageUrlToFirestore(String url) async {
    await FirebaseFirestore.instance.collection('gambar').add({
      'url': url,
      'created_at': Timestamp.now(),
    });
  }
}
