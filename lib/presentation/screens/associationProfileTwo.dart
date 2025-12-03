import 'package:dzevent/presentation/screens/add_event.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(AssocProfTwo());
}

class AssocProfTwo extends StatefulWidget {
  const AssocProfTwo({super.key});

  @override
  State<AssocProfTwo> createState() => _AssocProfTwoState();
}

class _AssocProfTwoState extends State<AssocProfTwo> {
  var logo =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0NfsQx_-GICZJcadqDeNBMvwzq-RInkcOzg&s";
  Widget getStatCard(String title, String subTitle) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(subTitle, style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget headerOfPage(String associationName, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircleAvatar(backgroundImage: NetworkImage(logo), radius: 64),
        ),
        Text(
          associationName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getStatCard('1.2K', "Subscribers"),
            SizedBox(width: 8),
            getStatCard('24', "Events"),
            SizedBox(width: 8),
            getStatCard('5.8K', "Interested"),
          ],
        ),
      ],
    );
  }

  Widget eventCard(
    String eventImage,
    String eventTitle,
    String eventDate,
    String eventTime,
    int numOfMembers,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Card(
              color: Colors.white,
              elevation: 1,
              child: Row(
                children: [
                  Image(image: NetworkImage(logo), width: 120, height: 120),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventTitle,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${eventDate}-${eventTime}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.people_outline, color: Colors.grey),
                          SizedBox(width: 2),
                          Text(
                            "${numOfMembers}interested",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Addevent()),
                  );
                },
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              headerOfPage(
                "Tech Innovators Alliance",
                "Driving the future of technology through collabotation and innovation",
              ),
              SizedBox(height: 32),
              //title
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Events",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      eventCard(
                        logo,
                        "Tech Innovators Meetup",
                        "2025-11-15",
                        "10:00 AM",
                        120,
                      ),
                      eventCard(
                        logo,
                        "Jazz Night",
                        "2025-12-02",
                        "7:30 PM",
                        85,
                      ),
                      eventCard(
                        logo,
                        "Modern Art Expo",
                        "2026-01-10",
                        "3:00 PM",
                        45,
                      ),
                      eventCard(
                        logo,
                        "City Marathon",
                        "2025-11-25",
                        "6:00 AM",
                        300,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
