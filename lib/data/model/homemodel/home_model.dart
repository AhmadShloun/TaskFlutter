import 'package:task_flutter/data/model/homemodel/data_model.dart';

class HomeModel {
  int? status;
  int? errorCode;
  DataModel? data;
  String? message;

  HomeModel({this.status, this.errorCode, this.data, this.message});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errorCode'] = errorCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}