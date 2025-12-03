import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/utils.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/presentation/screens/assocAdmin.dart';
import 'package:dzevent/presentation/widgets/input.dart';
import 'package:dzevent/presentation/widgets/submit_button.dart';
import 'package:dzevent/presentation/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

void main(List<String> args) {
  runApp(const Addevent());
}

class Addevent extends StatefulWidget {
  const Addevent({super.key});

  @override
  State<Addevent> createState() => _AddeventState();
}

enum _FormField {
  title,
  description,
  startDate,
  startTime,
  endDate,
  endTime,
  imageUrl,
  location,
  category,
}

class _AddeventState extends State<Addevent> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  late final Map<_FormField, TextEditingController> controllers;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    controllers = Map.fromEntries(
      _FormField.values
          .map(
            (field) => MapEntry<_FormField, TextEditingController>(
              field,
              TextEditingController(),
            ),
          )
          .toList(),
    );
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<EventsCubit>();
      final id = Uuid().v6();
      final title = controllers[_FormField.title]!.text;
      final description = controllers[_FormField.description]!.text;

      final startDate = DateTime.parse(controllers[_FormField.startDate]!.text);
      final startTime = parseTimeOfDay(
        str: controllers[_FormField.startTime]!.text,
      );
      final startDatetime = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        startTime.hour,
        startTime.minute,
      );

      // final endDate = DateTime.parse(controllers[_FormField.endDate]!.text);
      // final endTime = parseTimeOfDay(
      //   str: controllers[_FormField.endTime]!.text,
      // );
      // final endDatetime = DateTime(
      //   endDate.year,
      //   endDate.month,
      //   endDate.day,
      //   endTime.hour,
      //   endTime.minute,
      // );
      final endDatetime = DateTime.now();

      final imageUrl = controllers[_FormField.imageUrl]!.text;
      final location = controllers[_FormField.location]!.text;
      final createdAt = DateTime.now();
      final category = controllers[_FormField.category]!.text;
      final associationId = 1; // TODO : this is dummy.

      final event = EventModel(
        id: id,
        title: title,
        description: description,
        startDatetime: startDatetime,
        endDatetime: endDatetime,
        imageUrl: imageUrl,
        location: location,
        createdAt: createdAt,
        associationId: associationId,
        category: category,
      );
      await cubit.insert(event);
    }
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

          child: BlocListener<EventsCubit, EventsState>(
            listener: (context, state) {
              if (state is EventsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Failed to add the event. Error: \n ${state.error}",
                    ),
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),

                    TextInput(
                      title: "Event Title",
                      maximumLength: 100,
                      label: "Annual Tech Conference",
                      expand: false,
                    ),

                    SizedBox(height: 16),

                    SizedBox(
                      height: 200,
                      child: TextInput(
                        title: "Description",
                        maximumLength: 500,
                        label: "Join us for a day of insightful talks...",
                        expand: true,
                      ),
                    ),

                    DatetimeInput(
                      label: "Start Datetime",
                      timeController: controllers[_FormField.startTime]!,
                      dateController: controllers[_FormField.startDate]!,
                    ),
                    SizedBox(height: 8),
                    Input(
                      controller: controllers[_FormField.location]!,
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
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
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
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (_) {},
                        ),

                        SizedBox(height: 8),

                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton(
                        //     onPressed: () async {
                        //       final XFile? image = await _picker.pickImage(
                        //         source: ImageSource.gallery,
                        //       );
                        //       if (image != null) {
                        //         setState(() => _image = File(image.path));
                        //       }
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       elevation: 2,
                        //       backgroundColor: Colors.white,
                        //       textStyle: TextStyle(color: Colors.grey),
                        //     ),
                        //     child: const Text("Choose Image"),
                        //   ),
                        // ),
                        // _image != null
                        //     ? Image.file(_image!)
                        //     : const Icon(Icons.image, size: 150.0),
                        Column(
                          children: [
                            Button(
                              title: "Preview Event",
                              bgColor: Colors.grey.shade100,
                              textColor: Colors.black,
                            ),
                            SizedBox(height: 8),
                            Button(
                              title: "Post Event",
                              bgColor: Colors.blue,
                              textColor: Colors.white,
                              onPressed: submit,
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
        ),
      ),
    );
  }
}
