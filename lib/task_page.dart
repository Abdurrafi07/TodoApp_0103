import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DateTime? _selectedDate;
  bool _isDateInvalid = false;

  void _pickDate(BuildContext context) async {
    DateTime initialDate = _selectedDate ?? DateTime.now();

    showModalBottomSheet(context: context,
     builder: (BuildContext builder){
      return SizedBox(
        height: 300,
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Set Task Date & Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
                          Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: initialDate,
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: false,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      _isDateInvalid = false; // Reset error jika tanggal dipilih
                    });
                  },
                ),
              ),
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Task Date:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedDate == null
                            ? "Select a date"
                            : "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year} ${_selectedDate!.hour}:${_selectedDate!.minute}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today, color: Colors.blue),
                  onPressed: () => _pickDate(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
