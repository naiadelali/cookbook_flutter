import 'dart:convert';

import 'package:core_common/models/session_model.dart';
import 'package:core_common/navigation/app_navigation.dart';
import 'package:core_common/session/session_manager.dart';
import 'package:core_database/adapters/storage_adapter.dart';

class SessionDataSourceImpl extends SessionManager {
  final userSession = "com.app.template.core.database.data.session.user";
  final StorageAdapter storageAdapter;
  final AppNavigation appNavigation;

  SessionDataSourceImpl(this.storageAdapter, this.appNavigation);

  @override
  Future<bool> deleteUserSession({bool loginExpired = false}) async {
    final result = await storageAdapter.removeEncryptedString(userSession);

    if (loginExpired) {
      appNavigation.goToAuth();
    }
    return result;
  }

  @override
  Future<SessionModel?> getUserSession() async {
    final sessionData = await storageAdapter.getEncryptedString(userSession);

    if (sessionData != null) {
      final session = SessionModel.fromJson(jsonDecode(sessionData));
      return session;
    }

    return null;
  }

  @override
  Future<void> saveUserSession(SessionModel session) async {
    await storageAdapter.setEncryptedString(userSession, jsonEncode(session));
  }
}
