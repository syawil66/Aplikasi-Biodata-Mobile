import 'package:flutter/material.dart';
import '../models/biodata.dart';

class BiodataCard extends StatelessWidget {
  final Biodata biodata;

  const BiodataCard({super.key, required this.biodata});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              backgroundImage: biodata.fotoProfil != null
                  ? FileImage(biodata.fotoProfil!)
                  : null,
              child: biodata.fotoProfil == null
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text('Nama'),
              subtitle: Text(
                biodata.nama,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.badge, color: Colors.blue),
              title: const Text('NPM'),
              subtitle: Text(
                biodata.npm,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.school, color: Colors.blue),
              title: const Text('Jurusan'),
              subtitle: Text(
                biodata.jurusan,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}