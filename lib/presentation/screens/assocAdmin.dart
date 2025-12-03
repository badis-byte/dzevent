import 'package:dzevent/presentation/screens/associationProfileTwo.dart';
import 'package:dzevent/l10n/app_localizations.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          backgroundColor: colorr,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget cardAssoc(String title, String description, String date) {
    final loc = AppLocalizations.of(context)!;
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
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: Color.fromARGB(255, 107, 107, 107)),
              ),
              Text(
                loc.requestedOn(date),
                style: const TextStyle(color: Color.fromARGB(255, 107, 107, 107)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btn(loc.reject, Colors.red),
                  const SizedBox(width: 8),
                  btn(loc.accept, Colors.green),
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
    final loc = AppLocalizations.of(context)!;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) {
                            return IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (context) => const AssocProfTwo(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              loc.accountRequests,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: loc.searchHint,
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: const Color.fromARGB(17, 158, 158, 158),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
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
                            child: textButton(loc.all, Selected1),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Selected1 = false;
                                Selected2 = true;
                                Selected3 = false;
                                Selected4 = false;
                              });
                            },
                            child: textButton(loc.pending, Selected2),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Selected1 = false;
                                Selected2 = false;
                                Selected3 = true;
                                Selected4 = false;
                              });
                            },
                            child: textButton(loc.accepted, Selected3),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Selected1 = false;
                                Selected2 = false;
                                Selected3 = false;
                                Selected4 = true;
                              });
                            },
                            child: textButton(loc.rejected, Selected4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      children: [
                        // Dynamic association data — keep as is, don't translate
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
                        const SizedBox(height: 16),
                      ],
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

