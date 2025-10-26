import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        color: Color.fromARGB(255, 240, 242, 245),
        child: SingleChildScrollView(
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
              ),
              SizedBox(height: 20),
              buildInput(
                label: "Email Address",
                hint: "Enter your email address",
                pass: false,
              ),
              SizedBox(height: 20),
              buildInput(
                label: "Password",
                hint: "Enter your password",
                pass: true,
              ),
              SizedBox(height: 20),
              buildInput(
                label: "Confirm Password",
                hint: "Confirm your password",
                pass: true,
              ),
              SizedBox(height: 30),
              createButton(),
              SizedBox(height: 30),
              policy(),
              SizedBox(height: 30),
              yesAccount(),
              SizedBox(height: 30),
            ],
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
      child: ElevatedButton(
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
        },
        child: const Text('Create Account', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Column buildInput({
    required String label,
    required String hint,
    required bool pass,
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
          child: TextField(
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
}
