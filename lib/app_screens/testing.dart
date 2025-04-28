import 'package:flutter/material.dart';
import 'package:exp/database/local/db_helper.dart';
import '../model_classes/user_modelclass.dart';
import 'package:exp/provider/user_provider.dart';
import 'package:provider/provider.dart';

class UserContainer extends StatefulWidget {
  @override
  _UserContainerState createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer> {
  // List to store users
  late Future<List<usermodel>> _usersFuture;

  // Fetch users in initState
  @override
  void initState() {
    super.initState();
    _usersFuture = Provider.of<user_provider>(context, listen: false).getusers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users List")),
      body: FutureBuilder<List<usermodel>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while waiting
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Show error message if there's an issue fetching users
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Show message if no users found
            return Center(child: Text('No users found.'));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name ?? "No Name"),
                subtitle: Text(user.email ?? "No Email"),
                leading: Text(user.password != null ? "••••••••" : "No Password"), // Mask password
              );
            },
          );
        },
      ),
    );
  }
}
