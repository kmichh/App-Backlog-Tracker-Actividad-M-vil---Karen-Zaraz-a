class Item {
  final String titulo;
  final String categoria;
  final String? plataforma; // solo se usa cuando es película
  bool completado;

  Item({
    required this.titulo,
    required this.categoria,
    this.plataforma,
    this.completado = false,
  });

  bool get esLibro => categoria == 'Libro';

  String get estado {
    if (esLibro) return completado ? 'Leído' : 'Por leer';
    return completado ? 'Visto' : 'Por ver';
  }
}