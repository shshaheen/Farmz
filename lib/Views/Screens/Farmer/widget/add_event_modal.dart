import 'package:flutter/material.dart';

class AddEventModal extends StatefulWidget {
  final DateTime selectedDate;
  final Function(String, String) onSave;

  const AddEventModal({super.key, required this.selectedDate, required this.onSave});

  @override
  State<AddEventModal> createState() => AddEventModalState();
}

class AddEventModalState extends State<AddEventModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final description = _descController.text.trim();
                if (title.isNotEmpty && description.isNotEmpty) {
                  widget.onSave(title, description);
                  Navigator.pop(context);
                }
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
