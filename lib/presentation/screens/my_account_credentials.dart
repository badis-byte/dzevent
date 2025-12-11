import 'package:dzevent/data/models/user_model.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_bloc/flutter_bloc.dart';


class Myaccountcredentials extends StatefulWidget {
    static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => Myaccountcredentials());
  static const String pageRoute = "userprofile";
  const Myaccountcredentials({super.key});

  @override
  State<Myaccountcredentials> createState() => _MyaccountcredentialsState();
}

class _MyaccountcredentialsState extends State<Myaccountcredentials> {

  final ImagePicker picker = ImagePicker();

  // Controllers


  bool isEditingName = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    final email = context.read<AccountCubit>().currentUser!.email;
    final name = context.read<AccountCubit>().currentUser!.name;
    final pass = context.read<AccountCubit>().currentUser!.hashCode;
    final pic = context.read<AccountCubit>().currentUser!.profilePicture;
    String profile = pic;
    final emailCtrl = TextEditingController(text: email);
    final nameCtrl = TextEditingController(text: name);
    File? _profileImage;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(loc.editProfile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ------------------------------------------------------------------
            // PROFILE PICTURE
            // ------------------------------------------------------------------
            GestureDetector(
              onTap: ()=> _showImagePickerDialog(_profileImage),
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      foregroundColor: Colors.blue.shade800,
                      radius: 55,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : AssetImage(
                                  profile)
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.lightBlue,
                      child: const Icon(Icons.camera_alt,
                          size: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 40),

            // ------------------------------------------------------------------
            // EMAIL FIELD — ALWAYS READ ONLY
            // ------------------------------------------------------------------
            _buildStaticField(
              label: loc.email,
              controller: emailCtrl,
            ),

            const SizedBox(height: 25),

            // ------------------------------------------------------------------
            // NAME FIELD WITH EDIT ICON
            // ------------------------------------------------------------------
            _buildEditableName(loc, nameCtrl,name),

            const SizedBox(height: 25),

            // ------------------------------------------------------------------
            // PASSWORD FIELD WITH POPUP
            // ------------------------------------------------------------------
            _buildPasswordField(loc),
          ],
        ),
      ),
    );
  }

  // ==========================================================================
  // IMAGE PICKER POPUP
  // ==========================================================================
  void _showImagePickerDialog(_profileImage) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Profile Picture"),
        content: const Text("Choose image source"),
        actions: [
          TextButton(
            child: const Text("Camera"),
            onPressed: () async {
              Navigator.pop(context);
              final XFile? img = await picker.pickImage(source: ImageSource.camera);
              if (img != null) {
                setState(() => _profileImage = File(img.path));
              }
            },
          ),
          TextButton(
            child: const Text("Gallery"),
            onPressed: () async {
              Navigator.pop(context);
              final XFile? img = await picker.pickImage(source: ImageSource.gallery);
              if (img != null) {
                setState(() => _profileImage = File(img.path));
              }
            },
          ),
        ],
      ),
    );
  }

  // ==========================================================================
  // EMAIL — READ ONLY
  // ==========================================================================
  Widget _buildStaticField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: false,
          decoration: _inputDecor(),
        ),
      ],
    );
  }

  // ==========================================================================
  // EDITABLE NAME FIELD
  // ==========================================================================
 Widget _buildEditableName(AppLocalizations loc, TextEditingController nameCtrl, String originalName) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: nameCtrl,
              enabled: isEditingName,
              decoration: _inputDecor(),
            ),
          ],
        ),
      ),

      IconButton(
        icon: Icon(isEditingName ? Icons.check : Icons.edit),
        onPressed: () async {
          if (!isEditingName) {
            // Enter edit mode
            setState(() => isEditingName = true);
          } else {
            // Leaving edit mode → confirm dialog
            final confirmed = await _confirmNameChange(nameCtrl);

            if (confirmed == true) {
              // Save new name through cubit
              UserModel newuser = context.read<AccountCubit>().currentUser!;
              newuser.name = nameCtrl.text;

              context.read<AccountCubit>().update(newuser, newuser.id!);

              setState(() => isEditingName = false);
            } else {
              // Restore original text and exit edit mode
              setState(() {
                nameCtrl.text = originalName;
                isEditingName = false;
              });
            }
          }
        },
      ),
    ],
  );
}


  // Popup: confirm name change
  Future<bool?> _confirmNameChange(TextEditingController nameCtrl) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Confirm Name Change"),
      content: Text("Change your name to:\n\n${nameCtrl.text}?"),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context, false),
        ),
        ElevatedButton(
          child: const Text("Confirm"),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    ),
  );
}




bool isValidPassword(String pass) {
  final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
  return regex.hasMatch(pass);
}

  // ==========================================================================
  // PASSWORD FIELD → POPUP FOR OLD+NEW PASSWORD
  // ==========================================================================
  Widget _buildPasswordField(AppLocalizations loc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(loc.oldPassword,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextField(
                enabled: false,
                obscureText: true,
                decoration: _inputDecor().copyWith(hintText: "********"),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _passwordPopup(),
        ),
      ],
    );
  }

void _passwordPopup() {
  final oldCtrl = TextEditingController();
  final newCtrl = TextEditingController();

  final currentPass = context.read<AccountCubit>().currentUser!.hashCode.toString();
  showDialog(
    context: context,
    builder: (_) => StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Old Password"),
              ),
              TextField(
                controller: newCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Confirm"),
              onPressed: () {
                //OLD PASSWORD CHECK
                if (oldCtrl.text != currentPass) {
                  _showError("Old password is incorrect");
                  return;
                }
                // 2NEW PASSWORD VALIDATION
                if (!isValidPassword(newCtrl.text)) {
                  _showError(
                    "Password must be at least 8 characters, include:\n"
                    "• one uppercase letter\n"
                    "• one lowercase letter\n"
                    "• one number"
                  );
                  return;
                }
                // UPDATE & CLOSE POPUP
                UserModel updatedUser = context.read<AccountCubit>().currentUser!;
                // updatedUser.hashCode = newCtrl.text; // no hashcode in user model!! teeetttetetetttt thanks to mokhati!!!~

                context.read<AccountCubit>().update(updatedUser, updatedUser.id!);

                Navigator.pop(context); // Close popup ONLY
              },
            ),
          ],
        );
      },
    ),
  );
}



void _showError(String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Error"),
      content: Text(message),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}


  // ==========================================================================
  // INPUT DECORATION
  // ==========================================================================
  InputDecoration _inputDecor() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.green.withOpacity(0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
    );
  }
}
