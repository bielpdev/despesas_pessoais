// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {

  final String label;
final Function onPressed;

  const AdaptativeButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? CupertinoButton(padding: EdgeInsets.symmetric(horizontal: 20),
    onPressed: onPressed(), 
    child: Text(label),
    ) : ElevatedButton(onPressed: onPressed(), 
    child: Text(label),
    );
  }
}
