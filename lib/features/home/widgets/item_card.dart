import 'package:flutter/material.dart';
import 'package:mi_segunda_app/features/details/screens/detail_screen.dart';
import 'package:mi_segunda_app/features/home/models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onToggle;

  const ItemCard({super.key, required this.item, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final subtitulo = [
      item.categoria,
      item.estado,
      if (item.plataforma != null) item.plataforma!,
    ].join(' • ');

    return Card(
      color: item.completado ? Colors.green.shade100 : Colors.white,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        // libro vs película
        leading: Icon(
          item.esLibro ? Icons.menu_book : Icons.movie,
          size: 36,
          color: item.esLibro ? Colors.brown : Colors.redAccent,
        ),
        title: Text(
          item.titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: item.completado ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(subtitulo),
        // navegación: al tocar el elemento se abre la pantalla de detalles
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(item: item),
            ),
          );
        },
        trailing: IconButton(
          onPressed: onToggle,
          icon: Icon(
            item.completado ? Icons.check_circle : Icons.radio_button_unchecked,
            color: item.completado ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}