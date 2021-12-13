import 'package:flutter/material.dart';

class ApiResponse {
  final String value;
  final int code;

  const ApiResponse({@required this.code, @required this.value});
}
