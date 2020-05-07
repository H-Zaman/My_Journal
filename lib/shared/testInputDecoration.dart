import 'package:flutter/material.dart';

const customInputDecoration = InputDecoration(
//  fillColor: Colors.black,
//  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blueAccent,
      width: 5.0,
    )
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.green,
      width: 8.0,
    )
  )
);