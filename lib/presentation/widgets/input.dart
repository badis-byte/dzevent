import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String title;
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const Input({
    super.key,
    required this.title,
    required this.label,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(),
            suffixIcon: Icon(icon, color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class DateInput extends StatelessWidget {
  final String title;
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const DateInput({
    super.key,
    required this.title,
    required this.label,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          readOnly: true, // +1
          controller: controller,

          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(),
            suffixIcon: Icon(icon, color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 5)),
            );
            if (date != null) {
              controller.text = date.toIso8601String();
            }
          },
        ),
      ],
    );
  }
}

class TimeInput extends StatelessWidget {
  final String title;
  final String label;
  final IconData icon;
  final TextEditingController controller;

  const TimeInput({
    super.key,
    required this.title,
    required this.label,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          readOnly: true, // +1
          controller: controller,

          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(),
            suffixIcon: Icon(icon, color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),

          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              final v = "${time.hour}:${time.minute}";
              controller.text = v;
            }
          },
        ),
      ],
    );
  }
}

class DatetimeInput extends StatelessWidget {
  final String label;
  final TextEditingController dateController;
  final TextEditingController timeController;
  const DatetimeInput({
    super.key,
    required this.label,
    required this.dateController,
    required this.timeController,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                SizedBox(height: 8),
                // Date Column
                Expanded(
                  child: DateInput(
                    title: "Date",
                    label: "Select Date",
                    icon: Icons.calendar_month,
                    controller: dateController,
                  ),
                ),
                SizedBox(width: 16),
                // Time Column
                Expanded(
                  child: TimeInput(
                    title: "TIme",
                    label: "Select Time",
                    icon: Icons.access_time,
                    controller: timeController,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
