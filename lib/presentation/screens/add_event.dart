import 'package:dzevent/presentation/screens/assocAdmin.dart';
import 'package:dzevent/presentation/widgets/input.dart';
import 'package:dzevent/presentation/widgets/submit_button.dart';
import 'package:dzevent/presentation/widgets/text_input.dart';
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
                TextInput(
                  maximumLength: 100,
                  label: "Annual Tech Conference",
                  expand: false,
                ),
                SizedBox(height: 16),

                Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: TextInput(
                    maximumLength: 500,
                    label: "Join us for a day of insightful talks...",
                    expand: true,
                  ),
                ),

                Row(
                  children: [
                    // Date Column
                    Expanded(
                      child: Input(
                        title: "Date",
                        label: "Select Date",
                        icon: Icons.calendar_month,
                      ),
                    ),
                    SizedBox(width: 16),
                    // Time Column
                    Expanded(
                      child: Input(
                        title: "TIme",
                        label: "Select Time",
                        icon: Icons.access_time,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Input(
                  title: "Location",
                  label: "123Main Street,Anytown",
                  icon: Icons.location_on_outlined,
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
                        SubmitButton(
                          title: "Preview Event",
                          bgColor: Colors.grey.shade100,
                          textColor: Colors.black,
                        ),
                        SizedBox(height: 8),
                        SubmitButton(
                          title: "Post Event",
                          bgColor: Colors.blue,
                          textColor: Colors.white,
                        ),
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
