
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:staarm_mobile/app/app_database.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/app/storage_keys.dart';
import 'package:staarm_mobile/core/api/service_state.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';

import '../navigator_service.dart';
import 'user_cache_service.dart';

class UserCacheServiceImpl extends UserCacheService {
  static final _authService = locator<AuthService>();
  static final NavigationService _navigationService =
      locator<NavigationService>();

  static final BuildContext appContext =
      _navigationService.navigatorKey.currentContext;

  static const String folderName = StorageKeys.userCacheFolder;
  final _userCacheFolder = intMapStoreFactory.store(folderName);

  static Future<Database> get _db async => await AppDatabase.instance.database;

  @override
  Future<void> cacheUser(Map<dynamic, dynamic> data) async {
    await _userCacheFolder.delete(await _db);
    return await _userCacheFolder.add(await _db, data);
  }

  @override
  dynamic getCacheUser() async {
    final recordSnapshot = await _userCacheFolder.find(await _db);
    dynamic _data = recordSnapshot.first.value;
    return _data;
  }

  @override
  void deleteCacheUser() async {
    await _userCacheFolder.delete(await _db);
  }

  @override
  Future<bool> checkIfCacheUserExists() async {
    if (_db == null) return false;
    final recordSnapshot = await _userCacheFolder.find(await _db);
    return recordSnapshot.isNotEmpty;
  }

  @override
  Future<void> revalidateCache([bool updateProvider = true]) async {
    dynamic res = await _authService.getUser();

    if (res != null && res is SuccessState) {
      cacheUser(res.value);

      if (updateProvider) {
        try {
          //check is the user has a valid password set
          UserProvider _userProvider = Provider.of<UserProvider>(
            appContext,
            listen: false,
          );

          dynamic data = res.value;
          UserModel _user = _userProvider?.user;

          if (_user != null) {
            UserModel _prsn = UserModel.fromJson(data['data']['user']);
            _userProvider.saveUser(_prsn);
          }
          debugPrint("fetch User for the cache --- $data");
        } catch (e) {
          debugPrint("Catch error on parsing UserModel");
        }
      }
    }
  }
}
