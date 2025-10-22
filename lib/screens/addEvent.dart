import 'dart:io';

import 'package:dzevent/screens/assocAdmin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main(List<String> args) {
  runApp(const Addevent());
}

class Addevent extends StatefulWidget {
  const Addevent({super.key});

  @override
  State<Addevent> createState() => _AddeventState();
}

class _AddeventState extends State<Addevent> {
  String desc = "";
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
            }
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
                TextField(
                  cursorColor: Colors.black,
                  maxLength: 100,
                  decoration: InputDecoration(
                    label: Text(
                      "Annual Tech conference",
                      style: TextStyle(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: TextField(
                    cursorColor: Colors.black,
                    maxLength: 500,
                    maxLines: null,
                    expands: true,
                    onChanged: (value) {
                      setState(() {
                        desc = value;
                      });
                    },
                    textAlignVertical:
                        TextAlignVertical.top, //text starts from top
                    decoration: InputDecoration(
                      label: Text(
                        "Join us for a day of insightful talks...",
                        style: TextStyle(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    // Date Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date"),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Select date",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    // Time Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Time"),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Select time",
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Location"),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "123Main Street,Anytown",
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Event Category"),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: null, // init value
                      items:
                          [
                                "Tech",
                                "AI and Data Science",
                                "Business",
                                "Agriculture",
                                "Sociology",
                              ]
                              .map(
                                (fruit) => DropdownMenuItem(
                                  value: fruit,
                                  child: Text(fruit),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {},
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
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[400],
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            child: Text(
                              "Preview Event",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: Text(
                              "Post Event",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Column(

          // ),
        ),
      ),
    );
  }
}
