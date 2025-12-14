import 'package:dzevent/data/models/user_model.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/presentation/screens/user_profile.dart';
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

class _MyaccountcredentialsState extends State<Myaccountcredentials>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  
  
  final ImagePicker picker = ImagePicker();

  // Controllers


  bool isEditingName = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          loc.editProfile,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Gradient Header Background
          Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
            ),
          ),
          // Decorative circles
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Main Content
          FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 120),
                  // Profile Picture
                  ProfilePic(
                    image: 'https://i.postimg.cc/cCsYDjvj/user-2.png',
                    imageUploadBtnPress: () {},
                  ),
                  SizedBox(height: 20),
                  // Form Container
                  SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader(
                              context,
                              "Personal Information",
                              Icons.person_outline,
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              context,
                              label: loc.name,
                              initialValue: "Annette Black",
                              icon: Icons.person_outline,
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              context,
                              label: loc.email,
                              initialValue: "annette@gmail.com",
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              context,
                              label: loc.phone,
                              initialValue: "(316) 555-0116",
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              context,
                              label: loc.address,
                              initialValue: "New York, NVC",
                              icon: Icons.location_on_outlined,
                            ),
                            SizedBox(height: 32),
                            _buildSectionHeader(
                              context,
                              "Security",
                              Icons.lock_outline,
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              context,
                              label: loc.oldPassword,
                              initialValue: "demopass",
                              icon: Icons.lock_outline,
                              obscureText: !_showOldPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showOldPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showOldPassword = !_showOldPassword;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 16),
                            _buildTextField(
                              context,
                              label: loc.newPassword,
                              hint: loc.newPasswordHint,
                              icon: Icons.lock_reset,
                              obscureText: !_showNewPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showNewPassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showNewPassword = !_showNewPassword;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 32),
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      loc.cancel,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context).colorScheme.primary,
                                          Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.8),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(0.3),
                                          blurRadius: 12,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        shadowColor: Colors.transparent,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle_outline,
                                              size: 20, color: Colors.white),
                                          SizedBox(width: 8),
                                          Text(
                                            loc.saveUpdate,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    return Row(
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
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    String? initialValue,
    String? hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceContainer,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
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