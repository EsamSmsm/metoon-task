// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  FaqModel({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String question;
  String answer;
  String createdAt;
  String updatedAt;

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
