import 'package:flutter/material.dart';
import 'package:manage_clients/services/firebase_service.dart';

class AddClientPage extends StatelessWidget {
  const AddClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController();

    final directionController = TextEditingController();

    final mesController = TextEditingController();

    final TextEditingController yearController = TextEditingController();
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
        title: const Text(
          'Agregar Cliente',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: 'Nombre', prefixIcon: Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: directionController,
                decoration: const InputDecoration(
                    labelText: 'Dirección',
                    prefixIcon: Icon(Icons.location_on)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una dirección';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: mesController,
                decoration: const InputDecoration(
                    labelText: 'Mes', prefixIcon: Icon(Icons.calendar_month)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Porfavor ingresa un mes';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: yearController,
                decoration: const InputDecoration(
                    labelText: 'Año', prefixIcon: Icon(Icons.calendar_today)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Porfavor ingresa un año';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(150, 50),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  fixedSize: const Size(200, 60),
                ),
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    saveClients(nameController.text, directionController.text,
                        mesController.text, yearController.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Agregar Cliente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
