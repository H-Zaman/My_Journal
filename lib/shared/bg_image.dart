import 'package:flutter/material.dart';

customBackgroundImage (String image){
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(image),
      fit: BoxFit.fill
    )
  );
}