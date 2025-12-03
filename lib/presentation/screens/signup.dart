import 'package:dzevent/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        color: const Color.fromARGB(255, 240, 242, 245),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Text(
                loc.createNewAccount,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              googleButton(loc),
              const SizedBox(height: 20),
              orDevider(loc),
              const SizedBox(height: 35),
              buildInput(loc: loc, label: loc.fullName, hint: loc.fullNameHint, pass: false),
              const SizedBox(height: 20),
              buildInput(loc: loc, label: loc.emailAddress, hint: loc.emailAddressHint, pass: false),
              const SizedBox(height: 20),
              buildInput(loc: loc, label: loc.password, hint: loc.passwordHint, pass: true),
              const SizedBox(height: 20),
              buildInput(loc: loc, label: loc.confirmPassword, hint: loc.confirmPasswordHint, pass: true),
              const SizedBox(height: 30),
              createButton(loc),
              const SizedBox(height: 30),
              policy(loc),
              const SizedBox(height: 30),
              yesAccount(loc),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Row yesAccount(AppLocalizations loc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          loc.alreadyHaveAccount,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
        Text(
          " ${loc.logIn}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  Wrap policy(AppLocalizations loc) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          loc.byCreatingAccount,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
        Text(
          " ${loc.termsOfService}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Text(
          " ${loc.and}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
        Text(
          " ${loc.privacyPolicy}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  Container createButton(AppLocalizations loc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 51, 102),
          foregroundColor: Colors.white,
          minimumSize: const Size(400, 60),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
        onPressed: () => print('create account button pressed!'),
        child: Text(loc.createAccount, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Column buildInput({
    required AppLocalizations loc,
    required String label,
    required String hint,
    required bool pass,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 25),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color.fromARGB(255, 60, 59, 59),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 25, right: 25, top: 7),
          child: TextField(
            obscureText: pass,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 124, 124, 157),
                fontSize: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row orDevider(AppLocalizations loc) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 25,
            endIndent: 10,
          ),
        ),
        Text(
          "or",
          style: TextStyle(color: Color.fromARGB(255, 109, 107, 107), fontWeight: FontWeight.normal),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 10,
            endIndent: 25,
          ),
        ),
      ],
    );
  }

  Container googleButton(AppLocalizations loc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          minimumSize: const Size(400, 50),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Color.fromARGB(255, 205, 204, 204), width: 1),
          ),
        ),
        onPressed: () => print('google button pressed!'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google1.png", height: 35, width: 35),
            const SizedBox(width: 10),
            Text(loc.continueWithGoogle, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
