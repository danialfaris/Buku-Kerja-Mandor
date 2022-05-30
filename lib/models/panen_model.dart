import 'package:cloud_firestore/cloud_firestore.dart';

class AktivitasPanen{
  final String? id;
  final String tanggal;

  final String jenis;
  final String kode;
  final String sektor;
  final String blok;

  final int target;
  final int? realisasi;
  final int? liter;

  AktivitasPanen({
    this.id,
    required this.tanggal,

    required this.jenis,
    required this.kode,
    required this.sektor,
    required this.blok,

    required this.target,
    this.realisasi,
    this.liter,
  });

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'tanggal': tanggal,

      'jenis': jenis,
      'kode': kode,
      'sektor': sektor,
      'blok': blok,

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
        sektor = doc.data()!["sektor"],
        blok = doc.data()!["blok"],

        target = doc.data()!["target"],
        realisasi = doc.data()!["realisasi"],
        liter = doc.data()!["liter"];

}
