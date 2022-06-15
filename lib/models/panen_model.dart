import 'package:cloud_firestore/cloud_firestore.dart';

class AktivitasPanen{
  String? id;
  final String mandor;
  final String tanggal;
  final String jenis;

  final int? realisasi;

  AktivitasPanen({
    this.id,
    required this.mandor,
    required this.tanggal,
    required this.jenis,

    this.realisasi,
  });

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'mandor' : mandor,
      'tanggal': tanggal,
      'jenis': jenis,

      'realisasi': realisasi,
    };
  }

  AktivitasPanen.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        mandor = doc.data()!["mandor"],
        tanggal = doc.data()!["tanggal"],
        jenis = doc.data()!["jenis"],

        realisasi = doc.data()!["realisasiTotal"];
}
