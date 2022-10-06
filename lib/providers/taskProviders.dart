import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmanager/models/users.dart';

class Task with ChangeNotifier {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  DocumentReference getDocumentReference(id) {
    return getCollectionReference().doc(id);
  }

  add(Map<String, dynamic> data) async {
    String id = getID();
    data['uuid'] = id;
    data['created_at'] = DateTime.now();
    await getCollectionReference().doc(id).set(data);
  }

  update(Map<String, dynamic> data) async {
    data['updated_at'] = DateTime.now();
    await getDocumentReference(getID()).update(data);
  }

  updateByID(Map<String, dynamic> data, String documentUUID) async {
    data['updated_at'] = DateTime.now();
    data['uuid'] = documentUUID;
    await getDocumentReference(documentUUID).update(data);
  }

  deleteByID(String documentUUID) async{
    await getDocumentReference(documentUUID).delete();
  }

  @override
  CollectionReference getCollectionReference() {
    return db
        .collection("users")
        .doc(Users().getID())
        .collection("todo");
  }

  @override
  String getID() {
    return getCollectionReference().doc().id;
  }

  Stream<QuerySnapshot> getTodoListOfCurrentUser() {
    return getCollectionReference().snapshots();
  }

}