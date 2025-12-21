import 'followers_repo_base.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../remotecredentials.dart';

class FollowersRepoLocal extends FollowersRepoBase {
  final String base = baseUrl; // Django server
  
  @override
  Future<int> getFollowers(int assocId) async {
    final res = await http.get(Uri.parse("$baseUrl/followers/$assocId/count/"));
    if (res.statusCode != 200) throw Exception("Failed to get followers");
    return jsonDecode(res.body)['count'] as int;
  }

  @override
  Future<bool> follow(int userId, int assocId) async {
    final res = await http.post(
      Uri.parse("$baseUrl/followers/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId, "association_id": assocId}),
    );
    if (res.statusCode != 201) return false;
    return true;
  }

  @override
  Future<bool> unfollow(int userId, int assocId) async {
    final res = await http.delete(
      Uri.parse("$baseUrl/followers/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId, "association_id": assocId}),
    );
    if (res.statusCode != 200) return false;
    return true;
  }


  @override
  Future<List<int>> getFollowedAssociations(int userId) async {
    final res =
        await http.get(Uri.parse("$baseUrl/followers/user/$userId/"));
    if (res.statusCode != 200) throw Exception("Failed to get followed associations");
    final List<dynamic> data = jsonDecode(res.body);
    return data.map((e) => e['associationId'] as int).toList();
  }
}
