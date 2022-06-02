import 'package:cloud_firestore/cloud_firestore.dart';

class Aktivitas{
  final String? id;
  final String tanggal;

  final String jenis;
  final String kode;

  final int? target;
  final int? realisasi;
  final int? liter;

  Aktivitas({
    this.id,
    required this.tanggal,

    required this.jenis,
    required this.kode,

    this.target,
    this.realisasi,
    this.liter,
  });

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'tanggal': tanggal,

      'jenis': jenis,
      'kode': kode,

      'target': target,
      'realisasi': realisasi,
      'liter': liter,
    };
  }

  Aktivitas.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        tanggal = doc.data()!["tanggal"],
        jenis = doc.data()!["jenis"],
        kode = doc.data()!["kode"],

        target = doc.data()!["target"],
        realisasi = doc.data()!["realisasi"],
        liter = doc.data()!["liter"];

}
