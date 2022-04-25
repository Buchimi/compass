import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message(
      {Key? key, this.message, this.imgRef, required this.name})
      : super(key: key);

  final String? message;
  final String? imgRef;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
