import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

Future<String?> pickAndUploadFile(String folderName) async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);

  if (picked == null) return null;

  final file = File(picked.path);
  final fileName = basename(picked.path);
  final storageRef = FirebaseStorage.instance.ref().child(
    '$folderName/$fileName',
  );

  try {
    final uploadTask = await storageRef.putFile(file);
    final url = await uploadTask.ref.getDownloadURL();
    return url;
  } catch (e) {
    print('Upload error: $e');
    return null;
  }
}
