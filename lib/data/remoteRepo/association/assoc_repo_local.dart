import 'package:dzevent/data/models/assoc_model.dart';
import 'dart:convert';
import '../../databases/db_auth.dart';
import 'package:http/http.dart' as http;
import 'assoc_repo_base.dart';
import '../remotecredentials.dart';


class AssocRepoLocal extends AssocRepoBase {
  final String base = "$baseUrl/associations";

  @override
  Future<List<AssociationModel>> getData() async {
    final res = await http.get(Uri.parse(base));
    final body = jsonDecode(res.body) as List;
    return body.map((e) => AssociationModel.fromMap(e)).toList();
  }

  @override
  Future<bool> insertData(AssociationModel association) async {
    final res = await http.post(
      Uri.parse("$base/create/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(association.toJson()),
    );
    return res.statusCode == 201;
  }

  @override
  Future<bool> deleteAllData() async {
    final res = await http.delete(Uri.parse("$base/delete-all/"));
    return res.statusCode == 200;
  }

  @override
  Future<AssociationModel> login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$base/login/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (res.statusCode != 200) {
      throw Exception("Invalid credentials");
    }
  try{
    return AssociationModel.fromMap(jsonDecode(res.body));
  }catch(e){
    throw(InvalidCredException());
  }
  }

  @override
  Future<List<AssociationModel>> getUnverifiedUser() async {
    final res = await http.get(Uri.parse("$base/unverified/"));
    final list = jsonDecode(res.body) as List;
    return list.map((e) => AssociationModel.fromMap(e)).toList();
  }

  @override
  Future<List<AssociationModel>> getAssociation(int id) async {
    final res = await http.get(Uri.parse("$base/$id/"));
    final list = jsonDecode(res.body) as List;
    return list.map((e) => AssociationModel.fromMap(e)).toList();
  }

  @override
  Future<bool> verifyAssociation(int id) async {
    final res = await http.patch(Uri.parse("$base/$id/verify/"));
    return res.statusCode == 200;
  }

  @override
  Future<bool> deleteAssociation(int id) async {
    final res = await http.delete(Uri.parse("$base/$id/delete/"));
    return res.statusCode == 200;
  }
}