import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';

import '../models/activity_model.dart';
import '../models/karyawan_model.dart';
import '../models/panen_model.dart';
import '../models/hasil_kerja_model.dart';
import 'auth_services.dart';

class DatabaseService{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> ambilUsername(String? email) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _db
        .collection('akun').doc('$email').get();
    final String username = (snapshot.data()!["username"]);
    return username;
  }

  tambahAktivitas(Aktivitas aktivitasData) async {
    await _db.collection("Aktivitas").add(aktivitasData.toMap());
  }

  tambahAktivitasPanen(AktivitasPanen aktivitasData) async {
    final documentReference = FirebaseFirestore.instance.collection('AktivitasPanen').doc();
    aktivitasData.id = documentReference.id;
    await _db.collection("AktivitasPanen").doc('${aktivitasData.id}').set(aktivitasData.toMap());
    List<Karyawan> lk = await ambilKaryawan(aktivitasData.mandor);
    for (var o in lk) {
      await documentReference.update({
        "hasilKerja.${o.id}.tahun": "",
        "hasilKerja.${o.id}.blok": "",
        "hasilKerja.${o.id}.jelajah": 0,
        "hasilKerja.${o.id}.tandan": 0,
        "hasilKerja.${o.id}.kg": 0,
        "hasilKerja.${o.id}.brd": 0,
        "hasilKerja.${o.id}.jml": 0,
        "hasilKerja.${o.id}.pikul": 0,
      });
    }
    await documentReference.update({
      "hasilKerjaTotal.jelajah": 0,
      "hasilKerjaTotal.tandan": 0,
      "hasilKerjaTotal.kg": 0,
      "hasilKerjaTotal.brd": 0,
      "hasilKerjaTotal.jml": 0,
      "hasilKerjaTotal.pikul": 0,
    });
    print(lk);
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
    QuerySnapshot querySnap = await _db
        .collection('AktivitasPanen')
        .where('id', isEqualTo: aktivitas.id)
        .get();
    QueryDocumentSnapshot doc = querySnap.docs[0];
    DocumentReference docRef = doc.reference;
    await docRef.update({
      "hasilKerja.$KaryawanId.tahun": args.tahun,
      "hasilKerja.$KaryawanId.blok": args.blok,
      "hasilKerja.$KaryawanId.jelajah": args.jelajah,
      "hasilKerja.$KaryawanId.tandan": args.tandan,
      "hasilKerja.$KaryawanId.kg": args.kg,
      "hasilKerja.$KaryawanId.krd": args.brd,
      "hasilKerja.$KaryawanId.ml": args.jml,
      "hasilKerja.$KaryawanId.p": args.pikul,
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

  Future<AktivitasPanen> ambilAktivitasPanen(String? id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("AktivitasPanen").doc("$id").get();
    print(snapshot.data());
    return AktivitasPanen.fromDocumentSnapshot(snapshot);
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

  Future<List<Karyawan>> ambilKaryawan(String mandor) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("karyawan").where('mandor', isEqualTo: mandor).get();
    return snapshot.docs
        .map((docSnapshot) => Karyawan.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<LinkedHashMap> ambilHasilKerja(String? AktivitasId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("AktivitasPanen").doc("$AktivitasId").get();
    return snapshot.data()!["hasilKerja"];
  }

  Future<HasilKerja> ambilHasilKerjaTotal(String? AktivitasId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("AktivitasPanen").doc("$AktivitasId").get();
    return HasilKerja.fromHashMap(snapshot.data()!["hasilKerjaTotal"]);
  }

  updateHasilKerja(String? aktivitasId, String karyawanId, String jenis, var hasilkerja) async {
    QuerySnapshot querySnap = await _db
        .collection('AktivitasPanen')
        .where('id', isEqualTo: aktivitasId)
        .get();
    QueryDocumentSnapshot doc = querySnap.docs[0];
    DocumentReference docRef = doc.reference;
    await docRef.update({
      "hasilKerja.$karyawanId.$jenis": hasilkerja,
    });
  }

  updateHasilKerjaSemua(String? aktivitasId, LinkedHashMap args) async {
    QuerySnapshot querySnap = await _db
        .collection('AktivitasPanen')
        .where('id', isEqualTo: aktivitasId)
        .get();
    QueryDocumentSnapshot doc = querySnap.docs[0];
    DocumentReference docRef = doc.reference;
    num totalJelajah = 0;
    num totalTandan = 0;
    num totalKg = 0;
    num totalBrd = 0;
    num totalJml = 0;
    num totalPikul = 0;
    for (var o in args.keys) {
      num kg = int.parse(args[o]['tandan'].toString()) * 21;
      num jml = kg + int.parse(args[o]['brd'].toString());
      totalJelajah = totalJelajah + int.parse(args[o]['jelajah'].toString());
      totalTandan = totalTandan + int.parse(args[o]['tandan'].toString());
      totalBrd = totalBrd + int.parse(args[o]['brd'].toString());
      totalKg = totalKg + kg;
      totalJml = totalJml + int.parse(args[o]['jml'].toString());
      totalPikul = totalPikul + int.parse(args[o]['pikul'].toString());

      await docRef.update({
        "hasilKerja.$o.tahun": args[o]['tahun'],
        "hasilKerja.$o.blok": args[o]['blok'],
        "hasilKerja.$o.jelajah": args[o]['jelajah'],
        "hasilKerja.$o.tandan": args[o]['tandan'],
        "hasilKerja.$o.kg": kg.toString(),
        "hasilKerja.$o.brd": args[o]['brd'],
        "hasilKerja.$o.jml": jml.toString(),
        "hasilKerja.$o.pikul": args[o]['pikul'],
      });
      print("step $o");
    }

    await docRef.update({
      "hasilKerjaTotal.jelajah": totalJelajah,
      "hasilKerjaTotal.tandan": totalTandan,
      "hasilKerjaTotal.kg": totalKg,
      "hasilKerjaTotal.brd": totalBrd,
      "hasilKerjaTotal.jml": totalJml,
      "hasilKerjaTotal.pikul": totalPikul,
    });

    print("done");
  }
}