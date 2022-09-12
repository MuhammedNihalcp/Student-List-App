import 'package:flutter/material.dart';
import 'package:stutent_list/db/screen/widget/add_student_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Contact'),
      ),
      body: Column(
        children: [AddStudentsWidgeyt()],
      ),
    );
  }
}
