import 'package:dzevent/data/models/notification_model.dart';
import 'package:dzevent/data/remoteRepo/notifications/notif_supa_repo.dart';

abstract class NotifRepoBase {
  Future<List<NotificationModel>> getUserNotifications({required int userId});
  static NotifRepoBase? _historyInstance;

  static NotifRepoBase getInstance() {
    _historyInstance ??= NotifRepoSupa();
    return _historyInstance!; // For backend data
  }
}
