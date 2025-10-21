//this is association admin screen

import 'package:flutter/material.dart';

void main() {
  runApp(const Assocadmin());
}

class Assocadmin extends StatefulWidget {
  const Assocadmin({super.key});

  @override
  State<Assocadmin> createState() => _AssocadminState();
}

class _AssocadminState extends State<Assocadmin> {
  Widget textButton(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  var Selected1 = true;
  var Selected2 = false;
  var Selected3 = false;
  var Selected4 = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Account Requests",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      // search logic
                    },
                    decoration: InputDecoration(
                      hintText: "Search by association name...",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: const Color.fromARGB(17, 158, 158, 158),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Selected1 = true;
                                Selected2 = false;
                                Selected3 = false;
                                Selected4 = false;
                              });
                            },
                            child: textButton('All', Selected1),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Selected1 = false;
                                Selected2 = true;
                                Selected3 = false;
                                Selected4 = false;
                              });
                            },
                            child: textButton('Pending', Selected2),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Selected1 = false;
                                Selected2 = false;
                                Selected3 = true;
                                Selected4 = false;
                              });
                            },
                            child: textButton('Accepted', Selected3),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Selected1 = false;
                                Selected2 = false;
                                Selected3 = false;
                                Selected4 = true;
                              });
                            },
                            child: textButton('Rejected', Selected4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            "Tech Innovators Society",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "A community for tech enthusiasts and proffesionals.",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
