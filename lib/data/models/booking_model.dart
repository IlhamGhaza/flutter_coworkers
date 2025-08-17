import 'package:flutter_coworkers/data/models/worker_model.dart';
import 'package:intl/intl.dart';

class BookingModel {
  String userId;
  String workerId;
  DateTime date;
  int hiringDuration;
  double subtotal;
  double insurance;
  double tax;
  double platformFee;
  double grandTotal;
  String payWith;
  String status;
  String $id;
  String $createdAt;
  String $updatedAt;
  WorkerModel? worker;

  BookingModel({
    required this.userId,
    required this.workerId,
    required this.date,
    required this.hiringDuration,
    required this.subtotal,
    required this.insurance,
    required this.tax,
    required this.platformFee,
    required this.grandTotal,
    required this.payWith,
    required this.status,
    required this.$id,
    required this.$createdAt,
    required this.$updatedAt,
    this.worker,
  });

  factory BookingModel.fromJson(
    Map<String, dynamic> json, {
    WorkerModel? worker,
  }) => BookingModel(
    userId: json["user_id"],
    workerId: json["worker_id"],
    date: DateTime.parse(json["date"]),
    hiringDuration: json["hiring_duration"],
    subtotal: json["subtotal"]?.toDouble(),
    insurance: json["insurance"]?.toDouble(),
    tax: json["tax"]?.toDouble(),
    platformFee: json["platform_fee"]?.toDouble(),
    grandTotal: json["grand_total"]?.toDouble(),
    payWith: json["pay_with"],
    status: json["status"],
    $id: json["\$id"],
    $createdAt: json["\$createdAt"],
    $updatedAt: json["\$updatedAt"],
    worker: worker,
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "worker_id": workerId,
    "date": DateFormat('yyyy-MM-dd').format(date),
    "hiring_duration": hiringDuration,
    "subtotal": subtotal,
    "insurance": insurance,
    "tax": tax,
    "platform_fee": platformFee,
    "grand_total": grandTotal,
    "pay_with": payWith,
    "status": status,
    "\$id": $id,
    "\$createdAt": $createdAt,
    "\$updatedAt": $updatedAt,
  };

  Map<String, dynamic> toJsonRequest() => {
    "user_id": userId,
    "worker_id": workerId,
    "date": DateFormat('yyyy-MM-dd').format(date),
    "hiring_duration": hiringDuration,
    "subtotal": subtotal,
    "insurance": insurance,
    "tax": tax,
    "platform_fee": platformFee,
    "grand_total": grandTotal,
    "pay_with": payWith,
    "status": status,
  };
}
