
import 'package:flutter/material.dart';
import 'item_model.dart';
import 'add_item_screen.dart';
import 'categories_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final String username;

  MainScreen({required this.username});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<CollectionItem> items = [];
  List<CollectionItem> deletedItems = []; 
  List<String> categories = ['Все'];
  List<String> history = []; 
  String selectedCategory = 'Все';
  String searchQuery = '';
  int _selectedIndex = 0; 

  
  void _addNewItem(CollectionItem item) {
    setState(() {
      items.add(item);
      history.add('Добавлен: ${item.title}');
    });
  }

  
  void _deleteItem(int index) {
    setState(() {
      deletedItems.add(items[index]); 
      history.add('Удалено: ${items[index].title}');
      items.removeAt(index);
    });
  }

  
  void _restoreItem(CollectionItem item) {
    setState(() {
      items.add(item); 
      deletedItems.remove(item); 
      history.add('Восстановлен: ${item.title}');
    });
  }

  
  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            username: widget.username,
            history: history, 
            deletedItems: deletedItems, 
            onRestoreItem: _restoreItem, 
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final filteredItems = items.where((item) {
      final matchesCategory =
          selectedCategory == 'Все' || item.category == selectedCategory;
      final matchesSearchQuery = item.title
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesCategory && matchesSearchQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Моя коллекция'),
        actions: [
          IconButton(
            icon: Icon(Icons.category),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesScreen(
                    categories: categories,
                    onAddCategory: (category) {
                      setState(() {
                        categories.add(category);
                      });
                    },
                    onDeleteCategory: (category) {
                      setState(() {
                        categories.remove(category);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Поиск',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              items: categories.map((category) {
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
          ),
          
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text('Элементы не найдены'),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (ctx, index) {
                      final item = filteredItems[index];
                      return Dismissible(
                        key: ValueKey(item.title),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          final actualIndex = items.indexOf(item);
                          _deleteItem(actualIndex);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          leading: Image.network(item.imageUrl,
                              width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(item.title),
                          subtitle: Text(item.description),
                          onTap: () {
                            
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newItem = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(categories: categories),
            ),
          );
          if (newItem != null) {
            _addNewItem(newItem);
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Домой',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
