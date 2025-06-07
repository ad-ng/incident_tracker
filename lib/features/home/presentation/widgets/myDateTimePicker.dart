import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateTimePicker extends StatefulWidget {
  final TextEditingController dobController;
  const MyDateTimePicker({super.key, required this.dobController});

  @override
  State<MyDateTimePicker> createState() => _MyDateTimePickerState();
}

class _MyDateTimePickerState extends State<MyDateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dobController,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        label: Text('Date & Time', style: TextStyle(color: Colors.black)),
        prefixIcon: Icon(Icons.calendar_month, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        fillColor: Colors.blue[300],
        filled: true,
      ),
      readOnly: true,
      onTap: () => selectDateAndTime(context),
    );
  }

  Future<void> selectDateAndTime(BuildContext context) async {
    DateTime today = DateTime.now();

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blueAccent,
            dialogBackgroundColor: Colors.grey.shade100,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.blueAccent,
              dialogBackgroundColor: Colors.grey.shade100,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

      if (selectedTime != null) {
        DateTime combinedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        widget.dobController.text = DateFormat(
          'yyyy-MM-dd HH:mm',
        ).format(combinedDateTime);
      }
    }
  }
}
