import 'package:flutter/material.dart';


class MoreOptionsSheet extends StatelessWidget {
  final VoidCallback onReset; //alias funzione resetCounter

  const MoreOptionsSheet({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.refresh, color: Colors.red),
            title: const Text('Reset Counter'),
            onTap: () {
              onReset();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}