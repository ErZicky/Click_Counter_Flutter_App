import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clickapp/model/CounterModel.dart';

class CountersStorage {
  static const String key = 'counters_list';

  // Carica la lista di contatori da SharedPreferences
  Future<List<CounterModel>> loadCounters() async {
    final prefs = await SharedPreferences.getInstance();
    final String? countersJson = prefs.getString(key);

    if (countersJson == null) {
      return []; // Ritorna una lista vuota se non ci sono dati
    }

    try {
      final List<dynamic> decodedList = json.decode(countersJson);
      return decodedList.map((map) => CounterModel.fromMap(map)).toList();
    } catch (e) {
      print('Errror in loading counters: $e');
      return []; 
    }
  }

  // Salva la lista di contatori in SharedPreferences
  Future<void> saveCounters(List<CounterModel> counters) async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> countersMapList = [];

    for (var counter in counters) { // Itera attraverso ogni elemento della lista counters
      countersMapList.add(counter.toMap()); 
    }
    final String countersJson = json.encode(countersMapList);
    await prefs.setString(key, countersJson);
  }
}
