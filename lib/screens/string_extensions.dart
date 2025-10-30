// Helper para capitalizar la primera letra de un String
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return "";
    // Asegura que solo la primera letra sea mayúscula y el resto minúscula
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
