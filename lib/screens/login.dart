import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              ),
              SizedBox(height: 20),
              buildInput(label: "Password", hint: "Enter your password"),
              SizedBox(height: 10),
              forgotPassword(),
              SizedBox(height: 30),
              loginButton(),
              SizedBox(height: 30),
              orDevider(),
              SizedBox(height: 30),
              googleButton(),
              SizedBox(height: 30),
              noAccount(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Row noAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Dont't have an account?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          " Sign up",
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

  Container googleButton() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Button color
          foregroundColor: Colors.black, // Text color
          minimumSize: const Size(400, 60), // Width x Height
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // Rounded corners
            side: BorderSide(
              color: Colors.grey, // Border color
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

  Container loginButton() {
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
            borderRadius: BorderRadius.circular(6), // Rounded corners
          ),
          elevation: 5, // Shadow depth
        ),
        onPressed: () {
          print('Login button pressed!');
        },
        child: const Text('Login', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Container logoGetter() {
    return Container(
      height: 125,
      width: 125,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  Container forgotPassword() {
    return Container(
      margin: EdgeInsets.only(right: 25),
      child: Text(
        "Forgot Password?",
        textAlign: TextAlign.right,
        style: TextStyle(
          color: const Color.fromARGB(255, 37, 153, 237),
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
}
