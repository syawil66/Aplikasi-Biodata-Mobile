import 'dart:io';

class Biodata {
  final String nama;
  final String npm;
  final String jurusan;
  final File? fotoProfil;

  Biodata({
    required this.nama,
    required this.npm,
    required this.jurusan,
    this.fotoProfil,
  });
}