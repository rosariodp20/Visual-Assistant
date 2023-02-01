import 'package:flutter/material.dart';

AppBar homeAppBar = AppBar(
  backgroundColor: const Color(0xff0d7a9a),
  title: const Text('Visual Assistant'),
  leading: const FittedBox(
    child: Image(
      image: AssetImage('assets/images/white_logo.png'),
    ),
  ),
);

AppBar pageAppBar = AppBar(
  backgroundColor: const Color(0xff0d7a9a),
  title: const Text('Visual Assistant'),
);
