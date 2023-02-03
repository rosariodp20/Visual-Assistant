import 'package:shared_preferences/shared_preferences.dart';
import '../utils/shared_preferences_instance.dart';

class HistoryController {
  HistoryController._privateConstructor();

  static final HistoryController instance =
      HistoryController._privateConstructor();

  final SharedPreferences _preferences = SharedPreferencesInstance().instance;
  final String _historyKey = 'listaCronologiaPercorsi';

  List<String> getHistoryList() => _preferences.getStringList(_historyKey) ?? [];

  void removeFromHistory([int position = 0]) => _preferences.getStringList(_historyKey)?.removeAt(position);

  void addToFavourites({required String address}) {
    List<String> history = _preferences.getStringList(_historyKey) ?? [];

    if (history.length == 3) history.removeAt(0);

    history.add(address);
    _preferences.setStringList(_historyKey, history);
  }

}
