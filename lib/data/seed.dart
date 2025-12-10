// seed db for debugging/testing purposes

import 'dart:io';

import 'package:dzevent/data/models/assoc_model.dart';
import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/models/user_model.dart';
import 'package:dzevent/data/repo/association/assoc_repo_local.dart';
import 'package:dzevent/data/repo/events/events_repo.dart';
import 'package:dzevent/data/repo/user/user_repo_local.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

Future<bool> seed() async {
  final userRepo = UserRepoLocal();
  final assocRepo = AssocRepoLocal();
  final eventsRepo = EventsRepo();

  final userId = 1;
  final assocId = 1;

  final IsuserInserted = await userRepo.insertData(
    UserModel(
      id: userId,
      name: "abbas",
      email: "abbas@gmail.com",
      profilePicture: "no picture",
      createdAt: DateTime.now(),
    ),
  );
  if (!IsuserInserted) {
    return false;
  }
  final IsAssocInserted = await assocRepo.insertData(
    AssociationModel(
      id: assocId,
      name: "assoc",
      email: "assoc@email.com",
      profilePicture: "no picutre",
      bio: "no bio",
      createdAt: DateTime.now(),
      isVerified: false,
    ),
  );
  if (!IsAssocInserted) {
    return false;
  }

  final uuid = Uuid();
  for (int i = 0; i < 5; ++i) {
    final id = uuid.v4();
    final isEventInserted = await eventsRepo.insertData(
      EventModel(
        id: id,
        title: "event #$i",
        description: "no description",
        startDatetime: DateTime.now(),
        endDatetime: DateTime.now(),
        imageUrl: "no image",
        location: "no locatoin",
        createdAt: DateTime.now(),
        associationId: 1,
        category: "Tech",
      ),
    );
    if (!isEventInserted) {
      return false;
    }
    print("Evnet #${id} is inserted");
  }

  return true;
}

Future<void> main() async {
  if (Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  final success = await seed();
  print(success ? "Seed success" : "Seed failed");
}
