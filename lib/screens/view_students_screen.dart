import 'package:flutter/material.dart';
import 'package:sqflite_flutter_practice/_db_provider/db_provider_student_db_provider.dart';
import 'package:sqflite_flutter_practice/models/student_model.dart';
import 'package:sqflite_flutter_practice/screens/update_screen.dart';

class ViewStudentsScreen extends StatefulWidget {
  const ViewStudentsScreen({Key? key}) : super(key: key);

  @override
  State<ViewStudentsScreen> createState() => _ViewStudentsScreenState();
}

class _ViewStudentsScreenState extends State<ViewStudentsScreen> {
  List<String> item = ['Update', 'Delete'];
  StudentDbProvider? studentDbProvider;
  late Future<List<StudentModel>> future;
  String? value;

  @override
  void initState() {
    super.initState();
    studentDbProvider = StudentDbProvider();
    future = studentDbProvider!.fetchStudentsFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Students List'),
        ),
        body: FutureBuilder<List<StudentModel>>(
          future: studentDbProvider!.fetchStudentsFromDb(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          snapshot.data![index].id.toString(),
                        ),
                      ),
                      title: Text(snapshot.data![index].name!),
                      subtitle: Text(snapshot.data![index].email!),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Warning'),
                                  actions: [
                                    IconButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return UpdateScreen();
                                              },
                                              settings: RouteSettings(
                                                arguments: StudentModel(
                                                    id: snapshot
                                                        .data![index].id,
                                                    rollNo: snapshot
                                                        .data![index].rollNo,
                                                    name: snapshot
                                                        .data![index].name,
                                                    email: snapshot
                                                        .data![index].email,
                                                    fee: snapshot
                                                        .data![index].fee,
                                                    password: snapshot
                                                        .data![index].password),
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.update)),
                                    IconButton(
                                        onPressed: () async {
                                          //print(snapshot.data![index].id);
                                          await studentDbProvider!
                                              .deleteStudent(StudentModel(
                                                  id: snapshot.data![index].id,
                                                  rollNo: snapshot
                                                      .data![index].rollNo,
                                                  name: snapshot
                                                      .data![index].name,
                                                  email: snapshot
                                                      .data![index].email,
                                                  fee:
                                                      snapshot.data![index].fee,
                                                  password: snapshot
                                                      .data![index].password));
                                          setState(() {
                                            future = studentDbProvider!
                                                .fetchStudentsFromDb();
                                          });
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.delete)),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.menu)));
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Text('No Data');
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              print('called');
              future = studentDbProvider!.fetchStudentsFromDb();
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
