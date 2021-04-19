import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text("Home"),
            subtitle: Text("Click to go to home"),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text("Home"),
            subtitle: Text("Click to go to home"),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text("Home"),
            subtitle: Text("Click to go to home"),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text("Home"),
            subtitle: Text("Click to go to home"),
            leading: Icon(Icons.home),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
