import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TambahJasa extends StatefulWidget {
  static const routeName = '/tambah-jasa';

  @override
  _TambahJasaState createState() => _TambahJasaState();
}

class _TambahJasaState extends State<TambahJasa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  bool _isLoading = false;
  File? _selectedImage;

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.ref().child('jasa_images/$fileName');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<void> simpanJasa() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Silakan pilih gambar terlebih dahulu')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final imageUrl = await uploadImage(_selectedImage!);
      if (imageUrl == null) throw 'Upload gambar gagal';

      await FirebaseFirestore.instance.collection('jasa').add({
        'userId': uid,
        'judul': _judulController.text.trim(),
        'lokasi': _lokasiController.text.trim(),
        'harga': int.tryParse(_hargaController.text) ?? 0,
        'deskripsi': _deskripsiController.text.trim(),
        'imageUrl': imageUrl,
        'status': 'Aktif',
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Jasa berhasil ditambahkan')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Jasa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(labelText: 'Judul Jasa'),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _lokasiController,
                decoration: InputDecoration(labelText: 'Lokasi'),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Harga'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (int.tryParse(value) == null)
                    return 'Masukkan angka valid';
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 5,
                decoration: InputDecoration(labelText: 'Deskripsi Jasa'),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: pickImage,
                child:
                    _selectedImage == null
                        ? Container(
                          height: 150,
                          color: Colors.grey[200],
                          child: Center(
                            child: Text('Klik untuk memilih gambar'),
                          ),
                        )
                        : Image.file(
                          _selectedImage!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : simpanJasa,
                  child:
                      _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
