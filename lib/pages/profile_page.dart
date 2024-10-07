import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'ФИО'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'ПОЧТА'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'НОМЕР'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save profile changes logic
              },
              child: const Text('Редактировать'),
            ),
          ],
        ),
      ),
    );
  }
}