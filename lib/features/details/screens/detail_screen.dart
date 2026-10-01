import 'package:flutter/material.dart';
import 'package:mi_segunda_app/features/home/models/item.dart';

class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.titulo)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.esLibro ? Icons.menu_book : Icons.movie,
              size: 64,
              color: item.esLibro ? Colors.brown : Colors.redAccent,
            ),
            const SizedBox(height: 12),
            Text(
              item.titulo,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Categoría: ${item.categoria}'),
            const SizedBox(height: 8),
            Text('Estado: ${item.estado}'),
            if (item.plataforma != null) ...[
              const SizedBox(height: 8),
              Text('Plataforma: ${item.plataforma}'),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}