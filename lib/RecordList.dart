
import 'dart:convert';

class RecordList {
  RecordList({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final Data data;

  RecordList copyWith({
    int? status,
    String? message,
    Data? data,
  }) =>
      RecordList(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory RecordList.fromRawJson(String str) => RecordList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecordList.fromJson(Map<String, dynamic> json) => RecordList(
    status: json["Status"],
    message: json["Message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.totalRecords,
    required this.records,
  });

  final int totalRecords;
  final List<Record> records;

  Data copyWith({
    int? totalRecords,
    List<Record>? records,
  }) =>
      Data(
        totalRecords: totalRecords ?? this.totalRecords,
        records: records ?? this.records,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalRecords: json["TotalRecords"],
    records: List<Record>.from(json["Records"].map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TotalRecords": totalRecords,
    "Records": List<dynamic>.from(records.map((x) => x.toJson())),
  };
}

class Record {
  Record({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.collectedValue,
    required this.totalValue,
    required this.startDate,
    required this.endDate,
    required this.mainImageUrl,
  });

  final int id;
  final String title;
  final String shortDescription;
  final int collectedValue;
  final int totalValue;
  final String startDate;
  final String endDate;
  final String mainImageUrl;

  Record copyWith({
    int? id,
    String? title,
    String? shortDescription,
    int? collectedValue,
    int? totalValue,
    String? startDate,
    String? endDate,
    String? mainImageUrl,
  }) =>
      Record(
        id: id ?? this.id,
        title: title ?? this.title,
        shortDescription: shortDescription ?? this.shortDescription,
        collectedValue: collectedValue ?? this.collectedValue,
        totalValue: totalValue ?? this.totalValue,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      );

  factory Record.fromRawJson(String str) => Record.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["Id"],
    title: json["title"],
    shortDescription: json["shortDescription"],
    collectedValue: json["collectedValue"],
    totalValue: json["totalValue"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    mainImageUrl: json["mainImageURL"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "title": title,
    "shortDescription": shortDescription,
    "collectedValue": collectedValue,
    "totalValue": totalValue,
    "startDate": startDate,
    "endDate": endDate,
    "mainImageURL": mainImageUrl,
  };
}
