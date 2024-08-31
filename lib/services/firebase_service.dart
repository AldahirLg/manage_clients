import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manage_clients/models/client.dart';

FirebaseFirestore dbFirebase = FirebaseFirestore.instance;

//Solitar registros en base de adatos

Future<List<Client>> getClients() async {
  List<Client> clients = [];
  CollectionReference collectionReferenceClient =
      dbFirebase.collection('Client');
  QuerySnapshot queryClient = await collectionReferenceClient.get();

  for (var doc in queryClient.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final client = Client(
        name: data['name'],
        direction: data['direction'],
        mes: data['month'],
        year: data['year'],
        iud: doc.id,
        selectedMonths: List.generate(12, (index) => false));
    clients.add(client);
  }
  return clients;
}

//Guardar registros
Future<void> saveClients(
    String name, String direcction, String month, String year) async {
  await dbFirebase.collection('Client').add(
      {'name': name, 'direction': direcction, 'month': month, 'year': year});
}

// Actualizar registros
Future<void> updateClient(String iud, String newMonth, String newYear) async {
  await dbFirebase
      .collection('Client')
      .doc(iud)
      .update({'month': newMonth, 'year': newYear});
}

//Eliminar registros
Future<void> deleteClients(String iud) async {
  await dbFirebase.collection('Client').doc(iud).delete();
}
