import 'dart:convert';
import 'package:dzevent/data/databases/db_auth.dart';
import 'package:http/http.dart' as http;
import 'package:dzevent/data/models/user_model.dart';
import '../remotecredentials.dart';
import 'package:dzevent/data/remoteRepo/user/user_repo_base.dart';

class UserRepoLocal extends UserRepoBase {
  final String base = "$baseUrl/users";

  @override
  Future<List<UserModel>> getData() async {
    final res = await http.get(Uri.parse(base));
    final list = jsonDecode(res.body) as List;
    return list.map((e) => UserModel.fromMap(e)).toList();
  }

  @override
  Future<UserModel> insertData(UserModel post) async {
    final res = await http.post(
      Uri.parse("$base/create/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );
    final result = UserModel.fromMap(jsonDecode(res.body));
    return result;
  }

  @override
  Future<bool> deleteAllData() async {
    final res = await http.delete(Uri.parse("$base/delete-all/"));
    return res.statusCode == 200;
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$base/login/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (res.statusCode != 200) {
      throw Exception("Invalid credentials");
    }
    print(res.body);
    try{
    return UserModel.fromMap(jsonDecode(res.body));
  //return UserModel.fromJson(res.body);
    }catch(e){
      throw(InvalidCredException());
    }
  }

  @override
  Future<bool> update(UserModel value, int id) async {
    final res = await http.put(
      Uri.parse("$base/$id/update/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(value.toJson()),
    );
    return res.statusCode == 200;
  }

  @override
  Future<UserModel> getUserById(int id) async {
    final res = await http.get(Uri.parse("$base/$id/"));
    if (res.statusCode != 200) throw Exception("Not found");
    return UserModel.fromMap(jsonDecode(res.body));
  }
}