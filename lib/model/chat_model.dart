import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String? name;
  String? description;
  List<String>? renders;
  List<String>? parses;

  ChatModel({
    this.name,
    this.description,
    this.renders,
    this.parses,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    name: json["name"],
    description: json["description"],
    renders: json["renders"] == null ? [] : List<String>.from(json["renders"]!.map((x) => x)),
    parses: json["parses"] == null ? [] : List<String>.from(json["parses"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "renders": renders == null ? [] : List<dynamic>.from(renders!.map((x) => x)),
    "parses": parses == null ? [] : List<dynamic>.from(parses!.map((x) => x)),
  };
}
