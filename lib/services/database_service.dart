import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/activity_model.dart';

class DatabaseService{

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  tambahAktivitas(Aktivitas aktivitasData) async {
    await _db.collection("Aktivitas").add(aktivitasData.toMap());
  }

  updateAktivitas(Aktivitas aktivitasData) async {
    QuerySnapshot querySnap = await FirebaseFirestore
        .instance.collection('Aktivitas')
        .where('kode', isEqualTo: aktivitasData.kode)
        .get();
    QueryDocumentSnapshot doc = querySnap.docs[0];  // Assumption: the query returns only one document, THE doc you are looking for.
    DocumentReference docRef = doc.reference;
    await docRef.update(aktivitasData.toMap());
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

  Future<List<Aktivitas>> ambilAktivitasHari(String hariIni) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("Aktivitas").where('tanggal', isEqualTo: hariIni).get();
    return snapshot.docs
        .map((docSnapshot) => Aktivitas.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}