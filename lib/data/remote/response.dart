import 'package:flutter/material.dart';

@immutable
class Response {
  final bool isSuccessFul;
  final String message;
  final dynamic data;

  const Response(this.isSuccessFul, this.message, this.data);

  factory Response.fromJson(Map<String, dynamic> json) {
    final s = json['status'] as bool;
    final m = json['message'] as String;
    final d = json['record'] as dynamic;
    return Response(s, m, d);
  }
}
