import 'package:flutter/material.dart';

AppBar commonAppBar(
    {required Widget title,
    Widget? leading,
    List<Widget>? actions,
    required bool isCenter}) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    title: title,
    leading: leading,
    leadingWidth: leading != null ? null : 0.0,
    centerTitle: isCenter,
    actions: actions,
  );
}
