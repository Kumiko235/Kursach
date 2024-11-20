import 'package:flutter/material.dart';
import 'item_model.dart';
import 'edit_item_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  final CollectionItem item;

  ItemDetailScreen({required this.item, required void Function(dynamic updatedItem) onItemUpdated});

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late CollectionItem currentItem;

  @override
  void initState() {
    super.initState();
    currentItem = widget.item;
  }

  void _editItem() async {
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemScreen(item: currentItem),
      ),
    );

    if (updatedItem != null) {
      setState(() {
        currentItem = updatedItem;
      });
      Navigator.pop(context, updatedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали товара'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editItem,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: currentItem.imageUrl.isEmpty
                      ? Icon(Icons.image, size: 50, color: Colors.grey)
                      : Image.network(
                          currentItem.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Название:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                currentItem.title,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Описание:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                currentItem.description,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
