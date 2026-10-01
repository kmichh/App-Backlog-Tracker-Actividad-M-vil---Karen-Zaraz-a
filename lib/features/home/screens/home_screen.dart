import 'package:flutter/material.dart';
import 'package:mi_segunda_app/features/home/models/item.dart';
import 'package:mi_segunda_app/features/home/widgets/add_item_dialog.dart';
import 'package:mi_segunda_app/features/home/widgets/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _items = [];

  void _mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Future<void> _agregarItem() async {
    final nuevo = await showDialog<Item>(
      context: context,
      builder: (context) => const AddItemDialog(),
    );

    if (nuevo != null) {
      setState(() => _items.add(nuevo));
      _mostrarSnackBar('"${nuevo.titulo}" agregado correctamente');
    }
  }

  void _eliminarItem(int index) {
    final eliminado = _items[index];
    setState(() => _items.removeAt(index));
    _mostrarSnackBar('"${eliminado.titulo}" eliminado correctamente');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Mis Libros y Películas'),
      ),
      body: _items.isEmpty
          ? const Center(child: Text('No tienes libros ni películas pendientes. ¡Agrega alguno!'))
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                // 
                // dismissible: deslizar a izquierda o derecha para borrar
                return Dismissible(
                  key: ObjectKey(item),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _eliminarItem(index),
                  child: ItemCard(
                    item: item,
                    onToggle: () =>
                        setState(() => item.completado = !item.completado),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}