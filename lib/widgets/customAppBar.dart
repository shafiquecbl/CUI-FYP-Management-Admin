import 'package:flutter/material.dart';

customAppBar(
  text,
) {
  AppBar appBar = AppBar(
    title: Text(
      '$text',
    ),
  );
  return appBar;
}
