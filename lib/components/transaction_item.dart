// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transactionitem extends StatelessWidget {
  const Transactionitem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(6),
          child: FittedBox(
            child: Text(
              'R\$${tr.value}',
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
        title: Text(tr.title),
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? ElevatedButton.icon(
                onPressed: () => onRemove(tr.id),
                label: const Text('Excluir'),
                icon: const Icon(Icons.delete),
              )
            : IconButton(
                onPressed: () => onRemove(tr.id),
                icon: const Icon(Icons.delete),
                color: Colors.blue,
              ),
      ),
    );
  }
}
