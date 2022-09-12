import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stutent_list/db/function/db_function.dart';
import 'package:stutent_list/db/model/data_model.dart';
import 'package:stutent_list/db/screen/list_page.dart';

class AddStudentsWidgeyt extends StatelessWidget {
  AddStudentsWidgeyt({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Fill your Name';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.account_circle_outlined),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 10),
                    borderRadius: BorderRadius.circular(16)),
                hintText: 'Name',
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 208, 208),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Fill your age';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.add_reaction),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: 'Age',
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 208, 208),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'File your Phone Number';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: 'Phone',
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 208, 208),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'File your Email Id';
                }
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Please enter your valid email id';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: 'Email',
                filled: true,
                fillColor: const Color.fromARGB(255, 212, 208, 208),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  onAddStudents(context);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudents(BuildContext ctx) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _phone = _phoneController.text.trim();
    final _email = _emailController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _phone.isEmpty || _email.isEmpty) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          content: Text('Please File The Form'),
        ),
      );
    } else {
      final _student =
          StudentModel(name: _name, age: _age, phone: _phone, email: _email);
      addStudent(_student);
      Navigator.of(ctx).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const ListPage()));
    }
  }
}
