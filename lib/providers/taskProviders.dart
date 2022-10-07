/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmanager/models/task_model.dart';
import 'package:taskmanager/models/users.dart';

class Task with ChangeNotifier {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  final _firestore = FirebaseFirestore.instance;

  Future<void> addTask({required TaskModel task}) async {
    var taskcollection = _firestore.collection('tasks');
    await taskcollection.add(task.tojson());
  }

  Stream<List<TaskModel>> getTasks({required String mydate}) {
    return _firestore
        .collection('tasks')
        .where('date', isEqualTo: mydate)
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => TaskModel.fromjson(doc.data(), doc.id))
            .toList());
  }

  Future<void> updateTask(
      {required String title,
      note,
      docid,
      date,
      starttime,
      endtime,
      required int reminder,
      colorindex}) async {
    var taskcollection = _firestore.collection('tasks');
    await taskcollection.doc(docid).update({
      'title': title,
      'note': note,
      'date': date,
      'starttime': starttime,
      'endtime': endtime,
      'reminder': reminder,
      'colorindex': colorindex,
    });
  }

  Future<void> deleteTask({required String docid}) async {
    var taskcollection = _firestore.collection('tasks');
    await taskcollection.doc(docid).delete();
  }

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

  deleteByID(String documentUUID) async {
    await getDocumentReference(documentUUID).delete();
  }

  @override
  CollectionReference getCollectionReference() {
    return db.collection("users").doc(Users().getID()).collection("todo");
  }

  @override
  String getID() {
    return getCollectionReference().doc().id;
  }

  Stream<QuerySnapshot> getTodoListOfCurrentUser() {
    return getCollectionReference().snapshots();
  }
}
*/