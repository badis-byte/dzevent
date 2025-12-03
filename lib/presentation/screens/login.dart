import 'package:flutter/material.dart';
import 'package:dzevent/l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 240, 242, 245),
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              logoGetter(),
              Text(
                loc.welcomeBack,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              buildInput(
                label: loc.emailOrUsername,
                hint: loc.enterEmailOrUsername,
              ),
              const SizedBox(height: 20),
              buildInput(label: loc.password, hint: loc.enterYourPassword),
              const SizedBox(height: 10),
              forgotPassword(loc),
              const SizedBox(height: 30),
              loginButton(loc),
              const SizedBox(height: 30),
              orDevider(loc),
              const SizedBox(height: 30),
              googleButton(loc),
              const SizedBox(height: 30),
              noAccount(loc),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Row noAccount(AppLocalizations loc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          loc.dontHaveAccount,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          " ${loc.signUp}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 15,
            decoration: TextDecoration.none,
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
          minimumSize: const Size(400, 60),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        onPressed: () {
          print('Google button pressed!');
        },
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

  Row orDevider(AppLocalizations loc) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 25,
            endIndent: 10,
          ),
        ),
        Text(
          loc.or,
          style: const TextStyle(
            color: Color.fromARGB(255, 109, 107, 107),
            fontWeight: FontWeight.normal,
          ),
        ),
        const Expanded(
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

  Container loginButton(AppLocalizations loc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 51, 102),
          foregroundColor: Colors.white,
          minimumSize: const Size(400, 60),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 5,
        ),
        onPressed: () {
          print('Login button pressed!');
        },
        child: Text(loc.login, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Container logoGetter() {
    return SizedBox(
      height: 125,
      width: 125,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  Container forgotPassword(AppLocalizations loc) {
    return Container(
      margin: const EdgeInsets.only(right: 25),
      child: Text(
        loc.forgotPassword,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Color.fromARGB(255, 37, 153, 237),
          fontSize: 15,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Column buildInput({required String label, required String hint}) {
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
}
