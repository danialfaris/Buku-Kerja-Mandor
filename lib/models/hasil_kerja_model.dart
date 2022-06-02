import 'package:cloud_firestore/cloud_firestore.dart';

class HasilKerja{
  final String? id;
  final int? tahun;
  final String? blok;

  final int? luas;
  final int? tandan;
  final int? kg;
  final int? krd;
  final int? ml;
  final int? p;

  HasilKerja({
    this.id,
    this.tahun,
    this.blok,

    this.luas,
    this.tandan,
    this.kg,
    this.krd,
    this.ml,
    this.p,
  });

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'tahun': tahun,
      'blok': blok,

      'luas': luas,
      'tandan': tandan,
      'kg': kg,
      'krd': krd,
      'ml': ml,
      'p': p,
    };
  }

  HasilKerja.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        tahun = doc.data()!["tahun"],
        blok = doc.data()!["blok"],

        luas = doc.data()!["luas"],
        tandan = doc.data()!["tandan"],
        kg = doc.data()!["kg"],
        krd = doc.data()!["krd"],
        ml = doc.data()!["ml"],
        p = doc.data()!["p"];

}
