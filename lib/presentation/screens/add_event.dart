import 'dart:io';

import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/lib/utils.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/events/events_state.dart';
import 'package:dzevent/presentation/screens/associationProfileTwo.dart';
import 'package:dzevent/presentation/screens/map.dart';
import 'package:dzevent/presentation/widgets/input.dart';
import 'package:dzevent/presentation/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class Addevent extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => Addevent());
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

class _AddeventState extends State<Addevent>
    with SingleTickerProviderStateMixin {
  late final Map<_FormField, TextEditingController> controllers;
  late final GlobalKey<FormState> _formKey;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Map-related variables
  LatLng? _selectedLocation;
  String? _selectedAddress;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..forward();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllers[_FormField.title]!.text = event.title;
      controllers[_FormField.description]!.text = event.description;

      controllers[_FormField.startDate]!.text = event.startDatetime
          .toIso8601String()
          .split('T')[0];

      controllers[_FormField.startTime]!.text =
          '${event.startDatetime.hour.toString().padLeft(2, '0')}:${event.startDatetime.minute.toString().padLeft(2, '0')}';

      controllers[_FormField.endDate]!.text = event.endDatetime
          .toIso8601String()
          .split('T')[0];

      controllers[_FormField.endTime]!.text =
          '${event.endDatetime.hour.toString().padLeft(2, '0')}:${event.endDatetime.minute.toString().padLeft(2, '0')}';

      //controllers[_FormField.imageUrl]!.text = event.imageUrl;
      controllers[_FormField.location]!.text = event.location;
      controllers[_FormField.category]!.text = event.category;

      _selectedAddress = event.location;
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _openMapPicker() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => MapLocationPicker(
          initialLocation: _selectedLocation,
          initialAddress: _selectedAddress,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedLocation = result['location'] as LatLng;
        _selectedAddress = result['address'] as String;
        controllers[_FormField.location]!.text = _selectedAddress!;
      });
    }
  }

  Future<void> submit(File image) async {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<EventsCubit>();
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

      final imageUrl = DateTime.now().millisecondsSinceEpoch.toString() + imageURL!.split("/").last;
      final location = controllers[_FormField.location]!.text;
      final createdAt = widget.event?.createdAt ?? DateTime.now();
      final category = controllers[_FormField.category]!.text;
      final asso = context.read<AccountCubit>().currentAssociation;
      final associationId = asso!.id ?? 2;

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
        await cubit.update(event,false,image);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AssocProfTwo()),
        );
        return;
      }
      await cubit.insert(event, image);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AssocProfTwo()),
      );
    }
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
String? imageURL;
  Future<File?> pickImage ()async{
    final imagePicker = ImagePicker();
    XFile? picture = await imagePicker.pickImage(source: ImageSource.gallery);
    if(picture==null){
      return null;
    }
    final File file = File(picture.path);
    setState(() {
  imageURL= file.path;
  });
    return file;
  }

    
    File? image;
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.event != null;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isEditing ? Icons.edit_note : Icons.add_circle_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Text(
              isEditing ? "Edit Event" : "Create New Event",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocListener<EventsCubit, EventsState>(
              listener: (context, state) {
                if (state is EventsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.white),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Failed to ${isEditing ? 'update' : 'add'} the event. Error: \n ${state.error}",
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
                if (state is AddNewEventSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.white),
                          SizedBox(width: 12),
                          Text(
                            "Event ${isEditing ? 'Updated' : 'Added'} Successfully.",
                          ),
                        ],
                      ),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
                      // Basic Information Section
                      _buildSectionHeader(
                        "Basic Information",
                        Icons.info_outline,
                      ),
                      _buildCard(
                        child: Column(
                          children: [
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
                                label:
                                    "Join us for a day of insightful talks...",
                                expand: true,
                                controller:
                                    controllers[_FormField.description]!,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),

                      // Date & Time Section
                      _buildSectionHeader("Date & Time", Icons.calendar_today),
                      _buildCard(
                        child: Column(
                          children: [
                            DatetimeInput(
                              label: "Start Datetime",
                              timeController:
                                  controllers[_FormField.startTime]!,
                              dateController:
                                  controllers[_FormField.startDate]!,
                            ),
                            SizedBox(height: 16),
                            DatetimeInput(
                              label: "End Datetime",
                              timeController: controllers[_FormField.endTime]!,
                              dateController: controllers[_FormField.endDate]!,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),

                      // Location & Category Section
                      _buildSectionHeader(
                        "Details",
                        Icons.location_on_outlined,
                      ),
                      _buildCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Location with Map Button
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: controllers[_FormField.location]!,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Tap the map button to select location",
                                    prefixIcon: Icon(
                                      Icons.location_on_outlined,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.map,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                      onPressed: _openMapPicker,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline.withOpacity(0.3),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a location';
                                    }
                                    return null;
                                  },
                                ),
                                if (_selectedLocation != null) ...[
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          size: 16,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            "Location selected: ${_selectedLocation!.latitude.toStringAsFixed(4)}, ${_selectedLocation!.longitude.toStringAsFixed(4)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurface,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Event Category",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              initialValue: widget.event?.category,
                              validator: getIsRequiredValidator(
                                isRequired: true,
                              ),
                              decoration: InputDecoration(
                                labelText: "Select a category",
                                prefixIcon: Icon(Icons.category_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline.withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Theme.of(
                                  context,
                                ).colorScheme.surface,
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
                          ],
                        ),
                      ),
                      SizedBox(height: 24),

                      // Media Section
                      _buildSectionHeader("Media", Icons.image_outlined),
                      SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: OutlinedButton(
                              onPressed: ()async => { image = await pickImage()},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.visibility_outlined, size: 22),
                                      SizedBox(width: 8),
                                      Text(
                                        "Choose Picture",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                             ),

                      SizedBox(height: 32),
                          Column(children: [
                            if (imageURL != null)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.file(
                                          File(imageURL!), // convert path → File
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                          ],),

                      // Action Buttons
                      Column(
                        children: [
                          SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () => {if(image != null){
                                 print("start"),
                                 submit(image!),
                                 print("end")}
                                 },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isEditing ? Icons.update : Icons.publish,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      isEditing ? "Update Event" : "Post Event",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}