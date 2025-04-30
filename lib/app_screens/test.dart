import 'package:exp/provider/oder_provider.dart';
import 'package:exp/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UserProvider>(context).userList;
    print("Users: $users");

    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: Consumer<oder_provider>(
        builder: (context, orderProvider, child) {
          if (orderProvider.getalloder().isEmpty) {
            orderProvider.getoderfromdb();
            return Center(child: CircularProgressIndicator());
          }

          final orders = orderProvider.getalloder();

          if (orders.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text(order.name ?? 'No Name'),  // ✅ Access like a class
                subtitle: Text('Price: ${order.price}'),
              );
            },
          );
        },
      ),
    );
  }
}
