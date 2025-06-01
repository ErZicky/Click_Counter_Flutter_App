import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:clickapp/model/CounterModel.dart';
import 'package:clickapp/logic/countersStorage.dart';

class CounterViewModel extends ChangeNotifier {
  final CountersStorage countersstorage;
  List<CounterModel> _counters = [];
  bool _isLoading = false;

  List<CounterModel> get counters => _counters;
  bool get isLoading => _isLoading;

  CounterViewModel(this.countersstorage) {
    loadCounters(); // Carica i contatori all'inizializzazione del ViewModel
  }

  // Carica i contatori dalla repository
  Future<void> loadCounters() async {
    _isLoading = true;
    notifyListeners(); // Notifica che lo stato di caricamento è cambiato
    _counters = await countersstorage.loadCounters();
    _isLoading = false;
    notifyListeners(); // Notifica che i contatori sono stati caricati
  }

  // Aggiunge un nuovo contatore
  void addCounter(String name) {
    final newCounter = CounterModel(id: const Uuid().v4(), name: name);
    _counters.add(newCounter);
    countersstorage.saveCounters(_counters); // Salva i contatori aggiornati
    notifyListeners(); // Notifica i listener del cambiamento
  }

  // Elimina un contatore dato il suo ID
  void deleteCounter(String id) {
    _counters.removeWhere((counter) => counter.id == id);
    countersstorage.saveCounters(_counters); // Salva i contatori aggiornati
    notifyListeners(); // Notifica i listener del cambiamento
  }

  // Aggiorna un contatore esistente
  void updateCounter(CounterModel updatedCounter) {
    final index = _counters.indexWhere((c) => c.id == updatedCounter.id);
    if (index != -1) {
      _counters[index] = updatedCounter;
      countersstorage.saveCounters(_counters); // Salva i contatori aggiornati
      notifyListeners(); // Notifica i listener del cambiamento
    }
  }

  
}
