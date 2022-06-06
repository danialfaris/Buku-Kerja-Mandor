import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/activity_model.dart';
import '../models/karyawan_model.dart';
import '../models/panen_model.dart';
import '../models/hasil_kerja_model.dart';

class DatabaseService{

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  tambahAktivitas(Aktivitas aktivitasData) async {
    await _db.collection("Aktivitas").add(aktivitasData.toMap());
  }

  tambahAktivitasPanen(AktivitasPanen aktivitasData) async {
    final documentReference = FirebaseFirestore.instance.collection('AktivitasPanen').doc();
    aktivitasData.id = documentReference.id;
    await _db.collection("AktivitasPanen").doc('${aktivitasData.id}').set(aktivitasData.toMap());
  }

  updateAktivitas(Aktivitas aktivitasData) async {
    QuerySnapshot querySnap = await FirebaseFirestore
        .instance.collection('Aktivitas')
        .where('kode', isEqualTo: aktivitasData.kode)
        .get();
    QueryDocumentSnapshot doc = querySnap.docs[0];
    DocumentReference docRef = doc.reference;
    await docRef.update(aktivitasData.toMap());
  }

  updateAktivitasPanen(AktivitasPanen aktivitas, String KaryawanId, HasilKerja args) async {
    QuerySnapshot querySnap = await FirebaseFirestore
        .instance.collection('AktivitasPanen')
        .where('id', isEqualTo: aktivitas.id)
        .get();
    QueryDocumentSnapshot doc = querySnap.docs[0];
    DocumentReference docRef = doc.reference;
    await docRef.update({
      "hasilKerja.$KaryawanId.tahun": args.tahun,
      "hasilKerja.$KaryawanId.blok": args.blok,
      "hasilKerja.$KaryawanId.jelajah": args.luas,
      "hasilKerja.$KaryawanId.tandan": args.tandan,
      "hasilKerja.$KaryawanId.kg": args.kg,
      "hasilKerja.$KaryawanId.krd": args.krd,
      "hasilKerja.$KaryawanId.ml": args.ml,
      "hasilKerja.$KaryawanId.p": args.p,
    });
  }

  Future<void> hapusAktivitas(String documentId) async {
    await _db.collection("Aktivitas").doc(documentId).delete();

  }

  Future<List<Aktivitas>> ambilAktivitas() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("Aktivitas").get();
    return snapshot.docs
        .map((docSnapshot) => Aktivitas.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<AktivitasPanen>> ambilAktivitasPanen() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("AktivitasPanen").get();
    return snapshot.docs
        .map((docSnapshot) => AktivitasPanen.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<Aktivitas>> ambilAktivitasHari(String hariIni) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("Aktivitas").where('tanggal', isEqualTo: hariIni).get();
    return snapshot.docs
        .map((docSnapshot) => Aktivitas.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<AktivitasPanen>> ambilAktivitasPanenHari(String hariIni) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("AktivitasPanen").where('tanggal', isEqualTo: hariIni).get();
    return snapshot.docs
        .map((docSnapshot) => AktivitasPanen.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<Karyawan>> ambilKaryawan() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("karyawan").get();
    return snapshot.docs
        .map((docSnapshot) => Karyawan.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<HasilKerja>> ambilHasilKerja(String AktivitasId, String KaryawanId) async {
    print(AktivitasId);
    print(KaryawanId);
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("AktivitasPanen.$AktivitasId.hasilKerja.$KaryawanId.blok").get();

    return snapshot.docs
        .map((docSnapshot) => HasilKerja.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}