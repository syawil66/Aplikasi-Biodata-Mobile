import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/biodata.dart';
import '../widgets/biodata_card.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _npmController = TextEditingController();
  final TextEditingController _jurusanController = TextEditingController();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Object model untuk menyimpan hasil
  Biodata? _savedBiodata;

  // Fungsi untuk mengambil foto dari galeri
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Fungsi simpan data ke objek model
  void _simpanData() {
    if (_namaController.text.isEmpty ||
        _npmController.text.isEmpty ||
        _jurusanController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua bidang teks!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _savedBiodata = Biodata(
        nama: _namaController.text,
        npm: _npmController.text,
        jurusan: _jurusanController.text,
        fotoProfil: _imageFile,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Biodata berhasil disimpan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _npmController.dispose();
    _jurusanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Biodata Mahasiswa'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Input Foto Profile ---
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : null,
                    child: _imageFile == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _pickImage,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- Form Input Teks ---
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _npmController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'NPM',
                prefixIcon: Icon(Icons.badge_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _jurusanController,
              decoration: const InputDecoration(
                labelText: 'Jurusan',
                prefixIcon: Icon(Icons.school_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // --- Tombol Simpan ---
            ElevatedButton.icon(
              onPressed: _simpanData,
              icon: const Icon(Icons.save),
              label: const Text('Simpan Data'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 30),
            const Divider(thickness: 2),
            const SizedBox(height: 10),

            // --- Tampilan Hasil ---
            if (_savedBiodata != null) ...[
              const Text(
                'Hasil Biodata Tersimpan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              BiodataCard(biodata: _savedBiodata!),
            ],
          ],
        ),
      ),
    );
  }
}