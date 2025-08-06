import 'package:flutter/material.dart';

class EditFieldsDialog extends StatelessWidget {
  const EditFieldsDialog({
    super.key,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.onChanged,
  });
  final String confirmText;
  final String cancelText;
  final void Function()? onConfirm;
  final void Function()? onCancel;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                    border: buildBoarder(),
                    focusedBorder: buildBoarder(),
                    enabledBorder: buildBoarder(),
                    hintText: 'Enter the new value'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: onConfirm,
                child: Text(confirmText),
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildBoarder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    );
  }
}
