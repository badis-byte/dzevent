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

import 'package:uuid/uuid.dart';

void main(List<String> args) {
  runApp(Addevent());
}

class Addevent extends StatefulWidget {
  final EventModel? event;

  const Addevent({super.key, this.event});

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

    if (widget.event != null) {
      _populateFormFields(widget.event!);
    }
  }

  void _populateFormFields(EventModel event) {
    // Use WidgetsBinding to ensure controllers are ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllers[_FormField.title]!.text = event.title;
      controllers[_FormField.description]!.text = event.description;

      // Format dates - ISO8601 format (YYYY-MM-DD)
      controllers[_FormField.startDate]!.text = event.startDatetime
          .toIso8601String()
          .split('T')[0];

      // Format times - 24-hour format (HH:mm)
      controllers[_FormField.startTime]!.text =
          '${event.startDatetime.hour.toString().padLeft(2, '0')}:${event.startDatetime.minute.toString().padLeft(2, '0')}';

      controllers[_FormField.endDate]!.text = event.endDatetime
          .toIso8601String()
          .split('T')[0];

      controllers[_FormField.endTime]!.text =
          '${event.endDatetime.hour.toString().padLeft(2, '0')}:${event.endDatetime.minute.toString().padLeft(2, '0')}';

      controllers[_FormField.imageUrl]!.text = event.imageUrl;
      controllers[_FormField.location]!.text = event.location;
      controllers[_FormField.category]!.text = event.category;
    });
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
      // Use existing ID if editing, generate new ID if creating
      final id = widget.event?.id ?? Uuid().v6();
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

      final endDate = DateTime.parse(controllers[_FormField.endDate]!.text);
      final endTime = parseTimeOfDay(
        str: controllers[_FormField.endTime]!.text,
      );
      final endDatetime = DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        endTime.hour,
        endTime.minute,
      );

      final imageUrl = controllers[_FormField.imageUrl]!.text;
      final location = controllers[_FormField.location]!.text;
      final createdAt = widget.event?.createdAt ?? DateTime.now();
      final category = controllers[_FormField.category]!.text;
      final associationId =
          widget.event?.associationId ?? 2; // TODO : this is dummy.

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
      if (widget.event != null) {
        await cubit.update(event);
        return;
      }
      await cubit.insert(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.event != null;

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
          shape: Border(bottom: BorderSide(color: Colors.grey, width: 0.1)),
          title: Center(
            child: Text(
              isEditing ? "Edit Event" : "Create New Event",
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
                      "Failed to ${isEditing ? 'update' : 'add'} the event. Error: \n ${state.error}",
                    ),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
              if (state is AddNewEventSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Event ${isEditing ? 'Updated' : 'Added'} Successfully.",
                    ),
                    duration: Duration(seconds: 3),
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
                      controller: controllers[_FormField.title]!,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: TextInput(
                        title: "Description",
                        maximumLength: 500,
                        label: "Join us for a day of insightful talks...",
                        expand: true,
                        controller: controllers[_FormField.description]!,
                      ),
                    ),
                    SizedBox(height: 16),
                    DatetimeInput(
                      label: "Start Datetime",
                      timeController: controllers[_FormField.startTime]!,
                      dateController: controllers[_FormField.startDate]!,
                    ),
                    SizedBox(height: 16),
                    DatetimeInput(
                      label: " End Datetime",
                      timeController: controllers[_FormField.endTime]!,
                      dateController: controllers[_FormField.endDate]!,
                    ),
                    SizedBox(height: 16),
                    Input(
                      controller: controllers[_FormField.location]!,
                      label: "Location",
                      hint: "123Main Street,Anytown",
                      icon: Icons.location_on_outlined,
                    ),
                    SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Event Category"),
                        SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          initialValue: widget.event?.category,
                          validator: getIsRequiredValidator(isRequired: true),
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
                                    "Meetup",
                                  ]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            controllers[_FormField.category]!.text = value!;
                          },
                        ),
                        SizedBox(height: 8),
                        ImageInput(
                          label: "image",
                          hint: "",
                          icon: null,
                          controller: controllers[_FormField.imageUrl]!,
                        ),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Button(
                              title: "Preview Event",
                              bgColor: Colors.grey.shade100,
                              textColor: Colors.black,
                            ),
                            SizedBox(height: 8),
                            Button(
                              title: isEditing ? "Update Event" : "Post Event",
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
