import 'package:dzevent/l10n/app_localizations.dart';
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

  Widget inputTextField(String title, String hint, IconData iconLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 4),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(),
            suffixIcon: Icon(iconLabel, color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
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

  Widget textField(int maxLength, String label, bool expand) {
    return TextField(
      cursorColor: Colors.black,
      maxLength: maxLength,
      maxLines: null,
      expands: expand,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        label: Text(label, style: const TextStyle(color: Colors.grey)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

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
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Assocadmin()),
                  );
                },
              );
            },
          ),
          shape: const Border(
            bottom: BorderSide(color: Colors.grey, width: 0.1),
          ),
          title: Center(
            child: Text(
              loc.createNewEvent,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(loc.eventName,
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                textField(100, loc.eventNameHint, false),
                const SizedBox(height: 16),
                Text(loc.description,
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: textField(500, loc.descriptionHint, true),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: inputTextField(loc.date, loc.selectDate,
                          Icons.calendar_month),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: inputTextField(
                          loc.time, loc.selectTime, Icons.access_time),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                inputTextField(
                    loc.location, loc.locationHint, Icons.location_on_outlined),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.eventCategory,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: loc.selectCategory,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      items: [
                        loc.catTech,
                        loc.catAIData,
                        loc.catBusiness,
                        loc.catAgriculture,
                        loc.catSociology
                      ]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 8),
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
                          textStyle: const TextStyle(color: Colors.grey),
                        ),
                        child: Text(loc.chooseImage),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _image != null
                        ? Image.file(_image!)
                        : const Icon(Icons.image, size: 150.0),
                    const SizedBox(height: 16),
                    submitButton(loc.previewEvent, Colors.grey[100]!, Colors.black),
                    const SizedBox(height: 8),
                    submitButton(loc.postEvent, Colors.blue, Colors.white),
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
