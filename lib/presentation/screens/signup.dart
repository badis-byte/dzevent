import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var formkey = GlobalKey<FormState>();
  bool association = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passOneController = TextEditingController();
  var passTwoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        color: Color.fromARGB(255, 240, 242, 245),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Text(
                  "Create New Account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                googleButton(),
                SizedBox(height: 20),
                orDevider(),
                SizedBox(height: 35),
                buildInput(
                  label: "Full Name",
                  hint: "Enter your full name",
                  pass: false,
                  textcontroller: nameController,
                  validate: _nameValidate,
                ),
                SizedBox(height: 20),
                buildInput(
                  label: "Email Address",
                  hint: "Enter your email address",
                  pass: false,
                  textcontroller: emailController,
                  validate: _emailValidate,
                ),
                SizedBox(height: 20),
                buildInput(
                  label: "Password",
                  hint: "Enter your password",
                  pass: true,
                  textcontroller: passOneController,
                  validate: _passOneValidate,
                ),
                SizedBox(height: 20),
                buildInput(
                  label: "Confirm Password",
                  hint: "Confirm your password",
                  pass: true,
                  textcontroller: passTwoController,
                  validate: _passTwoValidate,
                ),
                SizedBox(height: 30),
                createButton(),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // centers the whole row
                  children: [
                    Text("Are you an Association?"),
                    const SizedBox(width: 8), // small spacing
                    Checkbox(
                      value: association,
                      onChanged: (value) {
                        setState(() {
                          print(value);
                          association = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                policy(),
                SizedBox(height: 30),
                yesAccount(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row yesAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          " Log In",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Wrap policy() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(
          "By creating an account, you agree to our",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          " Terms of Service",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          " and",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          " Privacy Policy",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Container createButton() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: BlocConsumer<AccountCubit, AccountState>(
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
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              elevation: 5, // Shadow depth
            ),
            onPressed: () {
              print('create account button pressed!');
              _process();
            },
            child: Text('Create Account', style: TextStyle(fontSize: 16)),
          );
        },
        listener: (context, state) {
          if (state is AccountError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AccountExists) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Email already exists")));
          } else if (state is UserFetched || state is AssociationFetched) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => EventFeed()),
            );
          }
        },
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
          margin: EdgeInsets.only(left: 25),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: const Color.fromARGB(255, 60, 59, 59),
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
              border: OutlineInputBorder(),
              hintText: hint,
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 124, 124, 157),
                fontSize: 15,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row orDevider() {
    return Row(
      children: const [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 25, // left spacing
            endIndent: 10, // space before "OR"
          ),
        ),
        Text(
          "or",
          style: TextStyle(
            color: Color.fromARGB(255, 109, 107, 107),
            fontWeight: FontWeight.normal,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 10, // space after "OR"
            endIndent: 25,
          ),
        ),
      ],
    );
  }

  Container googleButton() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Button color
          foregroundColor: Colors.black, // Text color
          minimumSize: const Size(400, 50), // Width x Height
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Rounded corners
            side: BorderSide(
              color: const Color.fromARGB(255, 205, 204, 204), // Border color
              width: 1, // Border width
            ),
          ),
          //elevation: 5,                           // Shadow depth
        ),
        onPressed: () {
          print('google button pressed!');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google1.png", height: 35, width: 35),
            SizedBox(width: 10),
            Text('Continue with Google', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  String? _nameValidate(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "Name is required";
    }

    // Remove extra spaces
    final parts = text.trim().split(RegExp(r'\s+'));

    if (parts.length < 2) {
      return "Please enter your full name (first and last)";
    }

    if (parts.any((part) => part.length < 2)) {
      return "Each name must be at least 2 characters";
    }

    return null;
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

  String? _passOneValidate(String? text) {
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

  String? _passTwoValidate(String? text) {
    if (text == null || text.isEmpty) {
      return "Please confirm your password";
    }

    if (text != passOneController.text) {
      return "Passwords do not match";
    }

    return null;
  }

  void _process() {
    if (formkey.currentState!.validate()) {
      context.read<AccountCubit>().register(
        nameController.text,
        emailController.text,
        passOneController.text,
        association,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please try again.')));
    }
  }
}
