import 'package:dzevent/presentation/screens/assocAdmin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main(List<String> args) {
  runApp(const Addevent());
}

class Addevent extends StatefulWidget {
  const Addevent({super.key});

  @override
  State<Addevent> createState() => _AddeventState();
}

class _AddeventState extends State<Addevent> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  Widget inputTextField(String title, String lable, IconData iconLable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          decoration: InputDecoration(
            hintText: lable,
            border: OutlineInputBorder(),
            suffixIcon: Icon(iconLable, color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget submitButton(String title, Color bgColor, Color textColor) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          textStyle: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        child: Text(
          title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget textField(int maximumLength, String label, bool expand) {
    return TextField(
      cursorColor: Colors.black,
      maxLength: maximumLength,
      maxLines: null,
      expands: expand,
      textAlignVertical: TextAlignVertical.top, //text starts from top
      decoration: InputDecoration(
        label: Text(label, style: TextStyle(color: Colors.grey)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Assocadmin()),
                  );
                },
              );
            },
          ),
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey, // border color
              width: 0.1, // border thickness
            ),
          ),
          title: Center(
            child: Text(
              "Create New Event",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  'Event Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                textField(100, "Annual Tech Conference", false),
                SizedBox(height: 16),
                Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: textField(
                    500,
                    "Join us for a day of insightful talks...",
                    true,
                  ),
                ),
                Row(
                  children: [
                    // Date Column
                    Expanded(
                      child: inputTextField(
                        "Date",
                        "Select Date",
                        Icons.calendar_month,
                      ),
                    ),
                    SizedBox(width: 16),
                    // Time Column
                    Expanded(
                      child: inputTextField(
                        "Time",
                        "Select Time",
                        Icons.access_time,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                inputTextField(
                  "Location",
                  "123Main Street,Anytown",
                  Icons.location_on_outlined,
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Event Category"),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Select a category",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      items:
                          [
                                "Tech",
                                "AI and Data Science",
                                "Business",
                                "Agriculture",
                                "Sociology",
                              ]
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: (_) {},
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            setState(() => _image = File(image.path));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          backgroundColor: Colors.white,
                          textStyle: TextStyle(color: Colors.grey),
                        ),
                        child: const Text("Choose Image"),
                      ),
                    ),
                    _image != null
                        ? Image.file(_image!)
                        : const Icon(Icons.image, size: 150.0),
                    Column(
                      children: [
                        submitButton(
                          "Preview Event",
                          Colors.grey[100]!,
                          Colors.black,
                        ),
                        SizedBox(height: 8),
                        submitButton("Post Event", Colors.blue, Colors.white),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
