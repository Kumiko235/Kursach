
import 'package:flutter/material.dart';
import 'item_model.dart';
import 'add_item_screen.dart';
import 'item_detail_screen.dart';

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<CollectionItem> items = [];

  void _addItem(CollectionItem item) {
    setState(() {
      items.add(item);
    });
  }

  void _updateItem(int index, CollectionItem updatedItem) {
    setState(() {
      items[index] = updatedItem;
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _navigateToAddItemScreen() async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemScreen(categories: [],)),
    );

    if (newItem != null) {
      _addItem(newItem);
    }
  }

  void _navigateToItemDetailScreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailScreen(
          item: items[index],
          onItemUpdated: (updatedItem) => _updateItem(index, updatedItem),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Моя коллекция'),
      ),
      body: items.isEmpty
          ? Center(child: Text('В коллекции нет предметов'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Image.network(
                    item.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.title),
                  subtitle: Text(item.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeItem(index),
                  ),
                  onTap: () => _navigateToItemDetailScreen(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddItemScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}
