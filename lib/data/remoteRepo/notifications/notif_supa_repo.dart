import 'dart:convert';

import 'package:dzevent/data/models/notification_model.dart';
import 'package:dzevent/data/remoteRepo/notifications/notif_base_repo.dart';
import '../remotecredentials.dart';
import 'package:http/http.dart' as http;

class NotifRepoSupa extends NotifRepoBase {
  final String base = "$baseUrl/users"; // Django server

  @override
  Future<List<NotificationModel>> getUserNotifications({
    required int userId,
  }) async {
    final res = await http.get(Uri.parse("$base/$userId/notifications"));
    if (res.statusCode != 200) {
      return [];
    } else {
      final List<dynamic> rawNotifs = jsonDecode(res.body);
      return rawNotifs
          .map((rawNotif) => NotificationModel.fromMap(rawNotif))
          .toList();
    }
  }
}
