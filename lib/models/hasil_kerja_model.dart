import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class HasilKerja{
  String? id;
  final String? tahun;
  final String? blok;

  final int? jelajah;
  final int? tandan;
  final int? kg;
  final int? brd;
  final int? jml;
  final int? pikul;

  HasilKerja({
    this.id,
    this.tahun,
    this.blok,

    this.jelajah,
    this.tandan,
    this.kg,
    this.brd,
    this.jml,
    this.pikul,
  });

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'tahun': tahun,
      'blok': blok,

      'jelajah': jelajah,
      'tandan': tandan,
      'kg': kg,
      'krd': brd,
      'jml': jml,
      'pikul': pikul,
    };
  }

  HasilKerja.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        tahun = doc.data()!["tahun"],
        blok = doc.data()!["blok"],

        jelajah = doc.data()!["jelajah"],
        tandan = doc.data()!["tandan"],
        kg = doc.data()!["kg"],
        brd = doc.data()!["brd"],
        jml = doc.data()!["jml"],
        pikul = doc.data()!["pikul"];

  HasilKerja.fromHashMap(LinkedHashMap doc)
      : id = doc["id"],
        tahun = doc["tahun"],
        blok = doc["blok"],

        jelajah = doc["jelajah"],
        tandan = doc["tandan"],
        kg = doc["kg"],
        brd = doc["brd"],
        jml = doc["jml"],
        pikul = doc["pikul"];

}
