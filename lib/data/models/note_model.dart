// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class NoteModel {
  int? id; // Nullable ID for new notes
  String title;
  String content;
  String language;
  String timeStamp;
  String dateStamp;

  NoteModel(
      {this.id,
      required this.title,
      required this.content,
      required this.language,
      required this.timeStamp,
      required this.dateStamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'language': language,
      'timeStamp': timeStamp,
      'dateStamp': dateStamp,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      content: map['content'] as String,
      language: map['language'] as String,
      timeStamp: map['timeStamp'] as String,
      dateStamp: map['dateStamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MyDateTime {
  final String date;
  final String time;

  MyDateTime({required this.date, required this.time});
  factory MyDateTime.fromDateTime(DateTime dateTime) {
    final list = DateFormat().format(dateTime).split(' ');
    final date = list.sublist(0, 3).join(' ');
    final time = list.sublist(3).join(' ');
    return MyDateTime(date: date, time: time);
  }
}
