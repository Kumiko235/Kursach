
import 'package:flutter/material.dart';
import 'item_model.dart';

class AddItemScreen extends StatefulWidget {
  final List<String> categories;

  AddItemScreen({required this.categories});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  String selectedCategory = 'Все';

  void _saveItem() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _imageController.text.isEmpty ||
        selectedCategory == 'Все') {
      return;
    }

    final newItem = CollectionItem(
      title: _titleController.text,
      description: _descriptionController.text,
      imageUrl: _imageController.text,
      category: selectedCategory,
    );

    Navigator.pop(context, newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Добавить элемент')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Заголовок'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Описание'),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'URL-адрес изображения'),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              items: widget.categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveItem,
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
