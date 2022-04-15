import 'package:flutter/material.dart';

class ColorUsers extends StatefulWidget {

  List<String> users;
  ColorUsers({Key? key, required this.users}) : super(key: key);

  @override
  State<ColorUsers> createState() => _ColorUsersState();
}

class _ColorUsersState extends State<ColorUsers> {

  @override
  void initState() {
    super.initState();

    widget.users = widget.users.toList()
      ..sort((a, b) => a.compareTo(b));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Users'),
      ),
      body: ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.users[index]),
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
