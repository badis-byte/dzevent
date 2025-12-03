import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:flutter/material.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          color: Color.fromARGB(255, 240, 242, 245),
          //margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                logoGetter(),
                Text(
                  "Welcome Back",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                buildInput(
                  label: "Email or username",
                  hint: "Enter email or username",
                  pass: false,
                  textcontroller: emailController,
                  validate: _emailValidate,
                ),
                SizedBox(height: 20),
                buildInput(
                  label: "Password",
                  hint: "Enter your password",
                  pass: true,
                  textcontroller: passController,
                  validate: _passValidate,
                ),
                SizedBox(height: 10),
                forgotPassword(loc),
                SizedBox(height: 30),
                loginButton(loc),
                SizedBox(height: 30),
                orDevider(loc),
                SizedBox(height: 30),
                googleButton(loc),
                SizedBox(height: 30),
                noAccount(loc),
                SizedBox(height: 40),
              ],
            ),
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
      margin: EdgeInsets.only(left: 25, right: 25),
      child: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is AccountError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AccountExists) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Email already exists")));
          }
          if (state is UserFetched || state is AssociationFetched) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => EventFeed()),
            );
          }
        },
        builder: (context, state) {
          if (state is AccountLoading) {
            return SizedBox(child: CircularProgressIndicator());
          }
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(
                255,
                0,
                51,
                102,
              ), // Button color
              foregroundColor: Colors.white, // Text color
              minimumSize: const Size(400, 60), // Width x Height
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), // Rounded corners
              ),
              elevation: 5, // Shadow depth
            ),
            onPressed: () {
              print('Login button pressed!');
              _process();
            },
            child: const Text('Login', style: TextStyle(fontSize: 16)),
          );
        },
      ),
    );
  }

  Widget logoGetter() {
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

  Column buildInput({
    required String label,
    required String hint,
    required bool pass,
    required TextEditingController textcontroller,
    required String? Function(String?)? validate,
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
          margin: EdgeInsets.only(left: 25, right: 25, top: 7),
          child: TextFormField(
            controller: textcontroller,
            validator: validate,
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

  String? _emailValidate(String? text) {
    if (text == null || text.isEmpty) {
      return "Email is required";
    }

    // Simple and effective regex
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    if (!regex.hasMatch(text)) {
      return "Enter a valid email";
    }

    return null;
  }

  String? _passValidate(String? text) {
    if (text == null || text.isEmpty) {
      return "Password is required";
    }

    if (text.length < 8) {
      return "Password must be at least 8 characters long";
    }

    if (!RegExp(r'[A-Z]').hasMatch(text)) {
      return "Password must contain at least one uppercase letter";
    }

    if (!RegExp(r'[a-z]').hasMatch(text)) {
      return "Password must contain at least one lowercase letter";
    }

    if (!RegExp(r'[0-9]').hasMatch(text)) {
      return "Password must contain at least one number";
    }

    return null;
  }

  void _process() {
    if (formkey.currentState!.validate()) {
      context.read<AccountCubit>().login(
        emailController.text,
        passController.text,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please try again.')));
    }
  }
}
