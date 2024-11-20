
import 'package:flutter/material.dart';
import 'item_model.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final List<String> history;
  final List<CollectionItem> deletedItems;
  final Function(CollectionItem) onRestoreItem;

  ProfileScreen({
    required this.username,
    required this.history,
    required this.deletedItems,
    required this.onRestoreItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Привет $username!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'История',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: history.isEmpty
                ? Center(
                    child: Text('Нет доступной истории.'),
                  )
                : ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        title: Text(history[index]),
                      );
                    },
                  ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Удаленные элементы',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: deletedItems.isEmpty
                ? Center(
                    child: Text('Нет удаленных элементов.'),
                  )
                : ListView.builder(
                    itemCount: deletedItems.length,
                    itemBuilder: (ctx, index) {
                      final item = deletedItems[index];
                      return ListTile(
                        leading: Image.network(item.imageUrl,
                            width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(item.title),
                        subtitle: Text(item.description),
                        trailing: IconButton(
                          icon: Icon(Icons.restore),
                          onPressed: () {
                            onRestoreItem(item);
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
