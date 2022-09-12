import 'package:flutter/material.dart';
import 'package:stutent_list/db/function/db_function.dart';
import 'package:stutent_list/db/model/data_model.dart';
import 'package:stutent_list/db/screen/home.dart';
import 'package:stutent_list/db/screen/widget/list_student_widget.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Contact List'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSerchDelegate());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [
            Expanded(child: ListStudentWidget()),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const ScreenHome()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CustomSerchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear_outlined))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_sharp));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                if (data.name.toLowerCase().contains(query.toLowerCase())) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('Name: ${data.name}'),
                        subtitle: Text(
                            'Age: ${data.age} \nPhone: ${data.phone} \nEmail: ${data.email}'),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.black,
                        ),
                      ),
                      const Divider()
                    ],
                  );
                } else {
                  return const Text('');
                }
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: studentList.length,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                if (data.name.toLowerCase().contains(query.toLowerCase())) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('Name: ${data.name}'),
                        subtitle: Text(
                            'Age: ${data.age} \nPhone: ${data.phone} \nEmail: ${data.email}'),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.black,
                        ),
                      ),
                      const Divider()
                    ],
                  );
                } else {
                  return const Text('');
                }
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: studentList.length,
            ),
          ),
        );
      },
    );
  }
}
