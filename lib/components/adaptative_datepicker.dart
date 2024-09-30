// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatepicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;
  const AdaptativeDatepicker({
    Key? key,
    required this.selectedDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _showDatePicker(BuildContext context) {
      showDatePicker(
        context: context,
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        onDateChanged(pickedDate);
      });
    }

    return Platform.isIOS
        ? Container(height: 180,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date, onDateTimeChanged: onDateChanged, minimumDate: DateTime(2019),
            initialDateTime: DateTime.now(), maximumDate: DateTime.now(),
            
          ),
        )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : 'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}',
                  ),
                ),
                ElevatedButton(
                    onPressed: () => _showDatePicker(context),
                    child: const Text('Selecionar Data'))
              ],
            ));
  }
}
