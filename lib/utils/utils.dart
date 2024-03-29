import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context)
          //  .removeCurrentSnackBar()
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(content: Text(text)));

  static DateTime toDateTime(Timestamp? value) {
    // if (value == null) return "";

    return value!.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps
              .map((json) => fromJson(json as Map<String, dynamic>))
              .toList();

          sink.add(objects);
        },
      );

  String returnMonth(DateTime date) {
    return DateFormat.MMMM().format(date);
  }
}
