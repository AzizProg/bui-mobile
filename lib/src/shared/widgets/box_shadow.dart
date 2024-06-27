import 'package:flutter/material.dart';

List<BoxShadow> customShadow(){
  return <BoxShadow>[
    BoxShadow(
        blurRadius: 5,

        color: Colors.black.withOpacity(0.2),
        offset: const Offset(0, 5)
    ),
  ];
}