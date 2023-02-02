import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shared_preferences_instance.dart';

class FavouritesController {
  FavouritesController._privateConstructor();

  static final FavouritesController instance =
      FavouritesController._privateConstructor();

  final SharedPreferences _preferences = SharedPreferencesInstance().instance;
  final String _favouritesKey = 'listaPercorsiPreferiti';

  List<String> getFavouritesList() =>
      _preferences.getStringList(_favouritesKey) ?? [];

  void removeFromFavouritesByPosition(int position) {
    List<String> favourites = _preferences.getStringList(_favouritesKey) ?? [];

    if(position > favourites.length) return;

    favourites.removeAt(position);
    _preferences.setStringList(_favouritesKey, favourites);
  }

  void removeByAddress(String address) {
    List<String> favourites = _preferences.getStringList(_favouritesKey) ?? [];

    if(!favourites.remove(address)) return;

    _preferences.setStringList(_favouritesKey, favourites);
  }

  void addToFavouritesByAddress(String address) {
    List<String> favourites = _preferences.getStringList(_favouritesKey) ?? [];

    if (favourites.length == 3) favourites.removeAt(0);

    favourites.add(address);
    _preferences.setStringList(_favouritesKey, favourites);
  }
}
