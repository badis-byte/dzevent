import 'package:flutter/material.dart';
import 'package:dzevent/l10n/app_localizations.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({super.key});

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  bool isEditing = false;

  // Controllers to preserve edited values
  final nameCtrl = TextEditingController(text: "Annette Black");
  final emailCtrl = TextEditingController(text: "annette@gmail.com");
  final phoneCtrl = TextEditingController(text: "(316) 555-0116");
  final addressCtrl = TextEditingController(text: "New York, NYC");
  final oldPasswordCtrl = TextEditingController(text: "demopass");
  final newPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        title: Text(loc.editProfile),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() => isEditing = true);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ProfilePic(
              image: 'https://i.postimg.cc/cCsYDjvj/user-2.png',
              imageUploadBtnPress: isEditing ? () {} : null,
            ),
            const Divider(),
            Form(
              child: Column(
                children: [
                  _buildField(loc.name, nameCtrl),
                  _buildField(loc.email, emailCtrl),
                  _buildField(loc.phone, phoneCtrl),
                  _buildField(loc.address, addressCtrl),
                  _buildField(loc.oldPassword, oldPasswordCtrl, obscure: true),
                  _buildField(loc.newPassword, newPasswordCtrl,
                      hint: loc.newPasswordHint),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // --- Buttons (only visible in edit mode) ---
            if (isEditing)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = false;
                          newPasswordCtrl.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).textTheme.bodyLarge!.color!
                                .withOpacity(0.08),
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(loc.cancel),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: send values to backend
                        setState(() => isEditing = false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BF6D),
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(loc.saveUpdate),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool obscure = false, String? hint}) {
    return UserInfoEditField(
      text: label,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        enabled: isEditing,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.green.withOpacity(0.05),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.imageUploadBtnPress,
  });

  final String image;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(radius: 50, backgroundImage: NetworkImage(image)),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, size: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({super.key, required this.text, required this.child});

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(text)),
          Expanded(flex: 3, child: child),
        ],
      ),
    );
  }
}
