import 'package:exp/model_classes/items_list.dart';
import 'package:exp/provider/stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminStockPage extends StatefulWidget {
  @override
  _AdminStockPageState createState() => _AdminStockPageState();
}

class _AdminStockPageState extends State<AdminStockPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<StockProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin - Stock Management')),
      body: Consumer<StockProvider>(
        builder: (context, provider, _) {
          final items = provider.list;

          return Stack(
            children: [
              items.isEmpty
                  ? Center(child: Text('No stock items found.'))
                  : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    color: Colors.grey.shade300,
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text(
                          'Price: ₹${item.price.toStringAsFixed(2)}\nCategory: ${item.category}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _nameController.text = item.name;
                              _priceController.text = item.price.toString();
                              _categoryController.text = item.category;
                              _imageController.text = item.image;

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit Item'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextField(
                                              controller: _nameController,
                                              decoration: InputDecoration(labelText: 'Name')),
                                          TextField(
                                              controller: _priceController,
                                              decoration: InputDecoration(labelText: 'Price'),
                                              keyboardType: TextInputType.number),
                                          TextField(
                                              controller: _categoryController,
                                              decoration: InputDecoration(labelText: 'Category')),
                                          TextField(
                                              controller: _imageController,
                                              decoration: InputDecoration(labelText: 'Image')),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Cancel')),
                                      ElevatedButton(
                                        onPressed: () {
                                          final updatedItem = item_model_class(
                                            id: item.id,
                                            name: _nameController.text,
                                            price: double.tryParse(_priceController.text) ?? 0.0,
                                            category: _categoryController.text,
                                            image: _imageController.text,
                                          );
                                          Provider.of<StockProvider>(context, listen: false)
                                              .updateItem(updatedItem);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              Provider.of<StockProvider>(context, listen: false)
                                  .deleteItem(item.id!);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    _nameController.clear();
                    _priceController.clear();
                    _categoryController.clear();
                    _imageController.clear();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Add Item'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(labelText: 'Name')),
                                TextField(
                                    controller: _priceController,
                                    decoration: InputDecoration(labelText: 'Price'),
                                    keyboardType: TextInputType.number),
                                TextField(
                                    controller: _categoryController,
                                    decoration: InputDecoration(labelText: 'Category')),
                                TextField(
                                    controller: _imageController,
                                    decoration: InputDecoration(labelText: 'Image')),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel')),
                            ElevatedButton(
                              onPressed: () {
                                final newItem = item_model_class(
                                  name: _nameController.text,
                                  price: double.tryParse(_priceController.text) ?? 0.0,
                                  category: _categoryController.text,
                                  image: _imageController.text,
                                );
                                Provider.of<StockProvider>(context, listen: false).addItem(newItem);
                                Provider.of<StockProvider>(context, listen: false).insertingData();
                                Navigator.pop(context);
                              },
                              child: Text('Add'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
