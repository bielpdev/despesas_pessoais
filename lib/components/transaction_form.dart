import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit, {super.key});

  submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    onSubmit(title, value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) => submitForm,
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitForm,
              controller: valueController,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            ElevatedButton(
              onPressed: submitForm,
              child: const Text('Nova Transação'),
            )
          ],
        ),
      ),
    );
  }
}
