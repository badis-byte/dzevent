//this is association admin screen

import 'package:dzevent/screens/addEvent.dart';
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

  Widget btn(String text, Color colorr) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorr, // Button color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          elevation: 4, // Shadow depth
        ),
        onPressed: () {},
        //style
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget cardAssoc(String title, String description, String date) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  color: const Color.fromARGB(255, 107, 107, 107),
                ),
              ),
              Text(
                "Requested on: $date",
                style: TextStyle(color: Color.fromARGB(255, 107, 107, 107)),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btn("Reject", Colors.red),
                  SizedBox(width: 8),
                  btn("Accept", Colors.green),
                ],
              ),
            ],
          ),
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
      debugShowCheckedModeBanner: false,
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
                        Builder(
                          builder: (context) {
                            return IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) => const Addevent(),
                                  ),
                                );
                              },
                            );
                          }
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
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: [
                        cardAssoc(
                          "Tech Innovators Society",
                          "A community for tech enthusiasts and professionals",
                          "2024-10-26",
                        ),
                        cardAssoc(
                          "Future Leaders Initiative",
                          "Empowering the next generation of innovators and leaders",
                          "2024-10-25",
                        ),

                        cardAssoc(
                          "AI Enthusiasts Club",
                          "Learn, share, and explore AI technologies together",
                          "2024-11-01",
                        ),

                        cardAssoc(
                          "Open Source Developers",
                          "Collaborate on open source projects and improve your skills",
                          "2024-11-05",
                        ),

                        cardAssoc(
                          "Cybersecurity Network",
                          "Stay updated with the latest in cybersecurity and ethical hacking",
                          "2024-11-10",
                        ),

                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
