import 'package:flutter/material.dart';
import 'package:mi_segunda_app/features/home/models/item.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final _tituloController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _categorias = ['Libro', 'Película'];
  final List<String> _plataformas = [
    'Netflix',
    'Disney+',
    'Prime Video',
    'HBO Max',
    'Apple TV+',
    'Cine',
    'Otra',
  ];

  String _categoriaSeleccionada = 'Libro';
  String _plataformaSeleccionada = 'Netflix';

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      final nuevo = Item(
        titulo: _tituloController.text.trim(),
        categoria: _categoriaSeleccionada,
        // plataforma solo se guarda si es película
        plataforma:
            _categoriaSeleccionada == 'Película' ? _plataformaSeleccionada : null,
      );
      Navigator.pop(context, nuevo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar elemento'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _tituloController,
              decoration:
                  const InputDecoration(labelText: 'Título del libro o película'),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Escribe un título'
                  : null,
            ),
            const SizedBox(height: 16),
            const Text('Categoría'),
            DropdownButton<String>(
              value: _categoriaSeleccionada,
              isExpanded: true,
              items: _categorias
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _categoriaSeleccionada = value);
                }
              },
            ),
            // solo aparece si es película
            if (_categoriaSeleccionada == 'Película') ...[
              const SizedBox(height: 16),
              const Text('Plataforma'),
              DropdownButton<String>(
                value: _plataformaSeleccionada,
                isExpanded: true,
                items: _plataformas
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _plataformaSeleccionada = value);
                  }
                },
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(onPressed: _guardar, child: const Text('Agregar')),
      ],
    );
  }
}