import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/presentation/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  Widget btn(String text, Color colorr, int associationId) {
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
        onPressed: () {
          if (text == AppLocalizations.of(context)!.accept) {
            try {
              context.read<AccountCubit>().verifyAccount(associationId);
              context.read<AccountCubit>().getUnvAssoc();
            } catch (e) {}
          } else {
            try {
              context.read<AccountCubit>().deleteAccount(associationId);
              context.read<AccountCubit>().getUnvAssoc();
            } catch (e) {}
          }
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget cardAssoc(AssociationModel asso, int id) {
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
                asso.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                asso.bio,
                style: const TextStyle(
                  color: Color.fromARGB(255, 107, 107, 107),
                ),
              ),
              Text(
                loc.requestedOn(asso.createdAt),
                style: const TextStyle(
                  color: Color.fromARGB(255, 107, 107, 107),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btn(loc.reject, Colors.red, id),
                  const SizedBox(width: 8),
                  btn(loc.accept, Colors.green, id),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AccountCubit>().getUnvAssoc();
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
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => Login()),
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
                    child: BlocConsumer<AccountCubit, AccountState>(
                      listener: (context, state) {
                        if (state is AssociationsFetched) {
                          print("data : ${state.association}");
                        } else {
                          print("state changed: $state");
                        }
                      },

                      builder: (context, state) {
                        if (state is AccountLoading) {
                          print("fetching data");
                          return Text("Fetching data ...");
                        }
                        if (state is AssociationsFetched) {
                          return ListView(
                            children: [
                              for (var asso in state.association)
                                cardAssoc(asso, asso.id!),
                              const SizedBox(height: 16),
                            ],
                          );
                        }
                        return Text("No data found");
                      },
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
