import 'package:cloud_firestore/cloud_firestore.dart';

class Karyawan {
  final String id;
  final String nama;

  Karyawan({required this.id, required this.nama});

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'nama': nama,
    };
  }

  Karyawan.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()!["id"],
        nama = doc.data()!["nama"];
}