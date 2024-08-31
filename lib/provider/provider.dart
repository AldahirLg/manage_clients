import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manage_clients/services/firebase_service.dart';
import '../models/client.dart';

class ClientProvider extends ChangeNotifier {
  List<Client> _clients = [];
  List<Client> _filteredClients = [];

  bool _initialized = false;

  bool get initialized => _initialized;
  List<Client> get filteredClients => _filteredClients;

  Future<void> fetchClients() async {
    _clients = await getClients();
    // Inicializar los meses seleccionados para cada cliente
    for (var client in _clients) {
      client.selectedMonths = List.generate(12, (index) => false);
      updateSelectedMonths(client, client.mes);
    }
    _filteredClients = _clients;
    notifyListeners();
  }

  void setInitialized(bool value) {
    _initialized = value;
  }

  Future<void> updatePay(String iud, String year) async {
    final client = _clients.firstWhere((c) => c.iud == iud);
    String selectMonthsString = getSelectedMonthsString(client);
    await updateClient(iud, selectMonthsString, year);
  }

  void filterClients(String query) {
    if (query.isEmpty) {
      _filteredClients = _clients;
    } else {
      _filteredClients = _clients
          .where((client) =>
              client.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void updateSelectedMonths(Client client, String storedMonths) {
    List<String> storedMonthsList =
        storedMonths.split(', ').map((e) => e.trim()).toList();

    for (int i = 0; i < months.length; i++) {
      if (storedMonthsList.contains(months[i])) {
        client.selectedMonths[i] = true;
      }
    }
  }

  String getSelectedMonthsString(Client client) {
    List<String> selectedMonths = [];
    for (int i = 0; i < client.selectedMonths.length; i++) {
      if (client.selectedMonths[i]) {
        selectedMonths.add(months[i]);
      }
    }
    return selectedMonths.join(', ');
  }

  void stateCheckBoxList(Client client, bool? value, int index) {
    client.selectedMonths[index] = value!;
    notifyListeners();
  }

  // Lista de meses
  final List<String> months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
}
