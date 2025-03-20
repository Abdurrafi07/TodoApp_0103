import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _nameController = TextEditingController();
  final List<Map<String, dynamic>> _tasks = [];
  DateTime? _selectedDate;
  bool _isDateInvalid = false;
  final _formKey = GlobalKey<FormState>();

  void _pickDate(BuildContext context) async {
    DateTime initialDate = _selectedDate ?? DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "Set Task Date & Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: initialDate,
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: false,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      _isDateInvalid =
                          false; // Reset error jika tanggal dipilih
                    });
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Select",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _addTask() {
    setState(() {
      _isDateInvalid = _selectedDate == null;
    });

    if (_formKey.currentState!.validate() && !_isDateInvalid) {
      setState(() {
        _tasks.add({
          'name': _nameController.text,
          'deadline': _selectedDate!,
          'isDone': false,
        });
        _nameController.clear();
        _selectedDate = null;
        _isDateInvalid = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Task added successfully"),
          behavior: SnackBarBehavior.floating, // Membuat snackbar mengambang
          margin: EdgeInsets.only(
            bottom: 80, // Atur agar tidak terlalu dekat dengan bawah
            left: 20,
            right: 20,
          ),
          backgroundColor: Colors.teal,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index]['isDone'] = !_tasks[index]['isDone'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Page"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Task Date:", style: TextStyle(fontSize: 16)),
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
                      if (_isDateInvalid)
                        const Text(
                          "Please select a date",
                          style: TextStyle(fontSize: 14, color: Colors.red),
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
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Task Name",
                        hintText: "Enter task name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter some text";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 95, 0, 112),
                    ),
                    onPressed: _addTask,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "List Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        _tasks[index]['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deadline: ${_tasks[index]['deadline'].day}-${_tasks[index]['deadline'].month}-${_tasks[index]['deadline'].year} ${_tasks[index]['deadline'].hour}:${_tasks[index]['deadline'].minute}",
                          ),
                          Text(
                            _tasks[index]['isDone'] ? "Done" : "Not Done",
                            style: TextStyle(
                              color:
                                  _tasks[index]['isDone']
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: _tasks[index]['isDone'],
                        onChanged: (value) => _toggleTaskStatus(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
