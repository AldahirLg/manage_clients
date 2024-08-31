class Client {
  String name;
  String direction;
  String mes; // Puedes mantener esto si lo necesitas
  String year;
  String iud;
  List<bool> selectedMonths;

  Client({
    required this.name,
    required this.direction,
    required this.mes,
    required this.year,
    required this.iud,
    required this.selectedMonths, // Añadir este campo
  });
}
