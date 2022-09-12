import 'package:flutter/material.dart';
import 'package:stutent_list/db/function/db_function.dart';
import 'package:stutent_list/db/model/data_model.dart';
import 'package:stutent_list/db/screen/widget/edit_screen_widget.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return ListTile(
                title: Text('Name: ${data.name}'),
                subtitle: Text(
                    'Age: ${data.age} \nPhone: ${data.phone} \nEmail: ${data.email}'),
                leading: const CircleAvatar(
                  backgroundColor: Colors.black,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(ctx).push(MaterialPageRoute(
                              builder: (ctx) => EditScreen(
                                  name: data.name,
                                  age: data.age,
                                  phone: data.phone,
                                  email: data.email,
                                  data: index)));
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                      onPressed: () {
                        deleteStudent(index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ));
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}
