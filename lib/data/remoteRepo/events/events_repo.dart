import 'dart:io';

import 'package:dzevent/data/models/event_model.dart';
import 'package:dzevent/data/remoteRepo/events/event_repo_base.dart';

import '../remotecredentials.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EventsRepo extends EventsRepoBase {
  final String base = "$baseUrl/events"; // Django server

  @override
  Future<List<EventModel>> getData() async {
    final res = await http.get(Uri.parse(base));
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((e) => EventModel.fromSupaMap(e)).toList();
  }

  @override
  Future<EventModel?> getEvent({required String id}) async {
    final res = await http.get(Uri.parse("$base/$id/"));
    if (res.statusCode != 200) return null;
    return EventModel.fromSupaMap(jsonDecode(res.body));
  }

  @override
  Future<List<EventModel>> getUserEvents(int id) async {
    final res = await http.get(Uri.parse("$base/association/$id/"));
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((e) => EventModel.fromSupaMap(e)).toList();
  }

  @override
  Future<List<EventModel>> getFilteredEvents({required List<String> filters}) async {
    final res = await http.post(
      Uri.parse("$base/filtered/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"filters": filters}),
    );
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((e) => EventModel.fromSupaMap(e)).toList();
  }

  @override
  Future<List<EventModel>> searchEvents({required String searchStr}) async {
    final res = await http.post(
      Uri.parse("$base/search/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"searchStr": searchStr}),
    );
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((e) => EventModel.fromSupaMap(e)).toList();
  }



  @override
  Future<bool> insertData(EventModel post, File image) async {
    try {
  final res = http.MultipartRequest(
    "POST",
    Uri.parse("$base/"),
  );
    post.toMap().forEach((key, value)=>
    res.fields[key] = value.toString()
  );

    res.files.add(
    await http.MultipartFile.fromPath("image", image.path),
  );
  final response = await res.send();
  return response.statusCode ==  201;

    } catch (e) {
      print(e); return false;
    }

    
  }

  @override
  Future<bool> updateRecord(EventModel value, String id) async {
    final res = await http.put(
      Uri.parse("$base/$id/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(value.toMap()),
    );
    return res.statusCode == 200;
  }

  @override
  Future<bool> deleteRecord(String id) async {
    final res = await http.delete(Uri.parse("$base/$id/"));
    return res.statusCode == 200;
  }

  @override
  Future<bool> deleteAllData() async {
    final res = await http.delete(Uri.parse("$base/delete/all/"));
    return res.statusCode == 200;
  }
}
