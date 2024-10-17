// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextfield extends StatelessWidget {

  final TextEditingController controller;
   final TextInputType keyBoardType;
   final Function(String) onSubmitted;
   final String label;
  
  const AdaptativeTextfield({
    super.key,
    required this.controller,
    required this.keyBoardType,
    required this.onSubmitted,
    required this.label,
  });



  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?  Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CupertinoTextField(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),controller: controller, keyboardType: keyBoardType, onSubmitted: onSubmitted, placeholder: label,),
    ) : TextField(keyboardType: keyBoardType,
                onSubmitted: onSubmitted,
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                ),
              );
  }
}

