import 'package:flutter/material.dart';
import 'package:manage_clients/provider/provider.dart';
import 'package:manage_clients/provider/searchProvider.dart';
import 'package:manage_clients/services/firebase_service.dart';
import 'package:provider/provider.dart';

class ViewClientsPage extends StatelessWidget {
  const ViewClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context, listen: false);
    final searchProvider = Provider.of<SearchProvider>(context);
    clientProvider.fetchClients();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blueAccent,
        title: searchProvider.isSearching
            ? TextField(
                onChanged: (query) {
                  clientProvider.filterClients(query);
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Buscar por nombre...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              )
            : const Text(
                'Ver Clientes',
                style: TextStyle(color: Colors.white),
              ),
        actions: [
          IconButton(
            style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
            icon: Icon(searchProvider.isSearching ? Icons.close : Icons.search),
            onPressed: () {
              searchProvider.toggleSearch();
              if (!searchProvider.isSearching) {
                clientProvider.filterClients('');
              }
            },
          ),
        ],
      ),
      body: Consumer<ClientProvider>(
        builder: (context, provider, child) {
          if (provider.filteredClients.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: provider.filteredClients.length,
              itemBuilder: (context, index) {
                final client = provider.filteredClients[index];
                return Dismissible(
                  key: Key(client.iud),
                  background: Container(
                    color: Colors.blueAccent,
                    child: const Icon(Icons.delete),
                  ),
                  onDismissed: (direction) async {
                    await deleteClients(client.iud);
                    provider.filteredClients.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                '¿Seguro que quieres eliminar a ${client.name}?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('Cancelar')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Estoy seguro')),
                            ],
                          );
                        });
                    return result;
                  },
                  direction: DismissDirection.endToStart,
                  child: ListTile(
                    title: Text(client.name),
                    subtitle: Text(client.direction),
                    onTap: () {
                      Navigator.pushNamed(context, '/registerPayment',
                          arguments: client);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
