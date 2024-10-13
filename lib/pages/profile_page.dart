import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController(text: 'Мальцев Иван Владимирович');
  final TextEditingController emailController = TextEditingController(text: 'example@mail.com');
  final TextEditingController phoneController = TextEditingController(text: '+71234567899');

  bool isEditable = false;

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
              controller: nameController,
              decoration: isEditable
                  ? InputDecoration(
                labelText: 'ФИО',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              )
                  : null,
              readOnly: !isEditable,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: isEditable
                  ? InputDecoration(
                labelText: 'ПОЧТА',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              )
                  : null,
              readOnly: !isEditable,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: isEditable
                  ? InputDecoration(
                labelText: 'НОМЕР',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              )
                  : null,
              readOnly: !isEditable,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditable = !isEditable;
                });
              },
              child: Text(isEditable ? 'Сохранить' : 'Редактировать'),
            ),
          ],
        ),
      ),
    );
  }
}