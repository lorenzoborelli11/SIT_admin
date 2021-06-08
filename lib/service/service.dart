import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Api {


  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  Api( this.path ) {
    ref = _db.collection(path);
  }


  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }


  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }



 
}
