// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  TodoModel({
    this.id,
    this.todoName,
    this.description,
    this.date,
    this.todoDone,
  });

  String? id;
  String? todoName;
  String? description;
  String? date;
  bool? todoDone;

  TodoModel copyWith({String? id,String? todoName,String? description,String? date,bool? todoDone}){

     return TodoModel(
       id: id ?? this.id,
       todoName: todoName ?? this.todoName,
       description: description ?? this.description,
       date: date ?? this.date,
       todoDone: todoDone ?? this.todoDone,
      );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json["id"],
    todoName: json["todoName"],
    description: json["description"],
    date: json["date"],
    todoDone: json["todoDone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "todoName": todoName,
    "description": description,
    "date": date,
    "todoDone": todoDone,
  };
}
