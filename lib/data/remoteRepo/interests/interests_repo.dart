import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/models/interest_model.dart';
import 'package:dzevent/data/remoteRepo/interests/interests_repo_base.dart';
import '../remotecredentials.dart';

class InterestsRepo extends InterestsRepoBase {
  final String base = baseUrl; // Django server

  //InterestsRepo({required this.baseUrl});

  @override
  Future<bool> createInterest({required InterestModel interest}) async {
    final res = await http.post(
      Uri.parse("$baseUrl/interests/create/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": interest.userId,
        "eventId": interest.eventId,
      }),
    );

    return res.statusCode == 201;
  }

  @override
  Future<bool> deleteInterest({
    required int userId,
    required String eventId,
  }) async {
    final res = await http.delete(
      Uri.parse("$baseUrl/interests/delete/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "eventId": int.parse(eventId),
      }),
    );

    return res.statusCode == 200;
  }

  @override
  Future<List<InterestModel>> getAllUserInterests({
    required int userId,
  }) async {
    final res = await http.get(
      Uri.parse("$baseUrl/interests/user/$userId/"),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to fetch interests");
    }

    final List data = jsonDecode(res.body);
    return data.map((e) => InterestModel.fromMap(e)).toList();
  }

  @override
  Future<InterestModel?> getInterest({
    required int userId,
    required String eventId,
  }) async {
    final res = await http.get(
      Uri.parse("$baseUrl/interests/$userId/${int.parse(eventId)}/"),
    );

    if (res.statusCode == 404) return null;
    if (res.statusCode != 200) {
      throw Exception("Failed to fetch interest");
    }

    return InterestModel.fromMap(jsonDecode(res.body));
  }

  @override
  Future<List<EventModel>> getUserInterestedEvents({
    required int userId,
  }) async {
    final res = await http.get(
      Uri.parse("$baseUrl/interests/user/$userId/events/"),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to fetch events");
    }

    final List data = jsonDecode(res.body);
    return data.map((e) => EventModel.fromSupaMap(e)).toList();
  }
}
