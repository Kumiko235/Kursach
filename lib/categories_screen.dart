
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  final List<String> categories;
  final Function(String) onAddCategory;
  final Function(String) onDeleteCategory;

  CategoriesScreen({
    required this.categories,
    required this.onAddCategory,
    required this.onDeleteCategory,
  });

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController _categoryController = TextEditingController();

  void _addCategory() {
    final newCategory = _categoryController.text.trim();
    if (newCategory.isNotEmpty && !widget.categories.contains(newCategory)) {
      widget.onAddCategory(newCategory);
      _categoryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Управление категориями')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(labelText: 'Новая категория'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addCategory,
                  child: Text('Добавить категори'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                return ListTile(
                  title: Text(category),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      widget.onDeleteCategory(category);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
