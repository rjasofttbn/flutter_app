// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

List<TodoModel> todoModelFromJson(dynamic str) => List<TodoModel>.from(
    (str as List<dynamic>).map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel {
  TodoModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
