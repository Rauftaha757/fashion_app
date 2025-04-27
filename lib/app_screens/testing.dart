import 'package:flutter/material.dart';
import 'package:exp/database/local/db_helper.dart';
import '../model_classes/user_modelclass.dart';

class UserContainer extends StatefulWidget {
  @override
  _UserContainerState createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer> {
  List<usermodel> users = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() async {
    List<usermodel> usersList = await DbHelper.getinstance().getallUsers();
    setState(() {
      users = usersList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users List")),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())  // Show loading while fetching
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name ?? "No Name"),
            subtitle: Text(user.email ?? "No Email"),
            leading: Text(user.password),
          );
        },
      ),
    );
  }
}
