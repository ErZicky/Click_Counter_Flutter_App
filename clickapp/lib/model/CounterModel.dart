class CounterModel {
  String id; // Un ID univoco per ogni contatore
  String name;
  int value;

  CounterModel({required this.id, required this.name, this.value = 0});

  // Metodo per creare un CounterModel da una mappa, utilizzato per leggere salvataggio
  factory CounterModel.fromMap(Map<String, dynamic> map) {
    return CounterModel(
      id: map['id'],
      name: map['name'],
      value: map['value'] ?? 0,
    );
  }

  // Metodo per convertire un CounterModel in una mappa, utilizzato per scrivere salvataggio
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
    };
  }
}