import 'package:elevenia_app/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClient extends BaseLocalStorageClient {
  SharedPreferenceClient._();

  static final SharedPreferenceClient _instance = SharedPreferenceClient._();
  static SharedPreferenceClient get instance => _instance;

  SharedPreferences? _sharedPreferences;
  Future<SharedPreferences> get _client async {
    if (_sharedPreferences != null) {
      return _sharedPreferences!;
    }

    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future getByKey(String key, SharedPrefType type) async {
    try {
      var data;
      SharedPreferences client = await _client;

      if (type == SharedPrefType.string) {
        data = client.getString(key);
      } else if (type == SharedPrefType.int) {
        data = client.getInt(key);
      }

      return data;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveByKey(data, String key, SharedPrefType type) async {
    SharedPreferences client = await _client;

    if (type == SharedPrefType.string) {
      await client.setString(key, data);
    } else if (type == SharedPrefType.int) {
      await client.setInt(key, data);
    }

    return;
  }

  @override
  Future<bool> deleteByKey(String key) async {
    try {
      SharedPreferences client = await _client;
      client.remove(key);

      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> clearAll() async {
    try {
      if (_sharedPreferences == null) {
        return false;
      }

      return await _sharedPreferences!.clear();
    } catch (e) {
      return false;
    }
  }
}
