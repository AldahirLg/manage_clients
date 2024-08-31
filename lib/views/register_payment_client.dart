import 'package:flutter/material.dart';
import 'package:manage_clients/routes/routes.dart';

class RegisterPaymentPage extends StatefulWidget {
  const RegisterPaymentPage({super.key});

  @override
  State<RegisterPaymentPage> createState() => _RegisterPaymentPageState();
}

class _RegisterPaymentPageState extends State<RegisterPaymentPage> {
  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final Client client = ModalRoute.of(context)!.settings.arguments as Client;

    TextEditingController nameController = TextEditingController();
    TextEditingController directionController = TextEditingController();
    TextEditingController monthController = TextEditingController();
    TextEditingController yearController = TextEditingController();

    nameController.text = client.name;
    directionController.text = client.direction;
    monthController.text = client.mes;
    yearController.text = client.year;

    if (!clientProvider.initialized) {
      clientProvider.updateSelectedMonths(client, monthController.text);
      clientProvider.setInitialized(true);
    }

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
          'Registrar Pago',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              enabled: false,
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Nombre', prefixIcon: Icon(Icons.person)),
            ),
            TextFormField(
              enabled: false,
              controller: directionController,
              decoration: const InputDecoration(
                  hintText: 'Dirección', prefixIcon: Icon(Icons.location_on)),
            ),
            TextFormField(
              controller: yearController,
              decoration: const InputDecoration(
                  hintText: 'Año', prefixIcon: Icon(Icons.history)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4.0,
                ),
                itemCount: clientProvider.months.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      clientProvider.months[index],
                      style: const TextStyle(fontSize: 14),
                    ),
                    value: client.selectedMonths[index],
                    onChanged: (bool? value) {
                      setState(() {
                        client.selectedMonths[index] = value!;
                      });
                    },
                  );
                },
              ),
            ),
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
                clientProvider.updatePay(client.iud, yearController.text);
                Navigator.pop(context);
              },
              child: const Text('Actualizar Pago'),
            ),
          ],
        ),
      ),
    );
  }
}
