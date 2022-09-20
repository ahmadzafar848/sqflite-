import 'package:flutter/material.dart';
import 'package:sqflite_flutter_practice/_db_provider/db_provider_student_db_provider.dart';
import 'package:sqflite_flutter_practice/models/student_model.dart';
import 'package:sqflite_flutter_practice/screens/view_students_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController rollNoTextEditingController;
  late TextEditingController nameTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController feeTextEditingController;
  late TextEditingController passwordTextEditingController;
  StudentDbProvider studentDbProvider = StudentDbProvider();
  bool isButtonActiveForRollNo = false;
  bool isButtonActiveForName = false;
  bool isButtonActiveForFee = false;
  bool isButtonActiveForEmail = false;
  bool isButtonActiveForPassword = false;

  @override
  void initState() {
    super.initState();
    rollNoTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    feeTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    rollNoTextEditingController.addListener(() {
      final isActiveButton = rollNoTextEditingController.text.isNotEmpty;
      setState(() {
        isButtonActiveForRollNo = isActiveButton;
      });
    });
    nameTextEditingController.addListener(() {
      final isActiveButton = nameTextEditingController.text.isNotEmpty;
      setState(() {
        isButtonActiveForName = isActiveButton;
      });
    });
    emailTextEditingController.addListener(() {
      final isActiveButton = emailTextEditingController.text.isNotEmpty;
      setState(() {
        isButtonActiveForEmail = isActiveButton;
      });
    });
    feeTextEditingController.addListener(() {
      final isActiveButton = feeTextEditingController.text.isNotEmpty;
      setState(() {
        isButtonActiveForFee = isActiveButton;
      });
    });
    passwordTextEditingController.addListener(() {
      final isActiveButton = passwordTextEditingController.text.isNotEmpty;
      setState(() {
        isButtonActiveForPassword = isActiveButton;
      });
    });
  }

  @override
  void dispose() {
    rollNoTextEditingController.dispose();
    nameTextEditingController.dispose();
    feeTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.1,
                  child: Text('Insert Student'),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                SizedBox(
                  height: height * 0.1,
                  width: width * 0.8,
                  child: TextFormField(
                    controller: rollNoTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Roll Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                SizedBox(
                  height: height * 0.1,
                  width: width * 0.8,
                  child: TextFormField(
                    controller: nameTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                SizedBox(
                  height: height * 0.1,
                  width: width * 0.8,
                  child: TextFormField(
                    controller: emailTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                SizedBox(
                  height: height * 0.1,
                  width: width * 0.8,
                  child: TextFormField(
                    controller: feeTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Fee',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                SizedBox(
                  height: height * 0.1,
                  width: width * 0.8,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                GestureDetector(
                  onTap: isButtonActiveForName &&
                          isButtonActiveForRollNo &&
                          isButtonActiveForEmail &&
                          isButtonActiveForFee &&
                          isButtonActiveForPassword
                      ? () async {
                          String rollNo = rollNoTextEditingController.text;
                          String email = emailTextEditingController.text;
                          String fee = feeTextEditingController.text;
                          String name = nameTextEditingController.text;
                          String password = passwordTextEditingController.text;
                          bool result = await studentDbProvider.insertStudent(
                            StudentModel(
                                rollNo: rollNo,
                                name: name,
                                email: email,
                                fee: fee,
                                password: password),
                          );
                          if (result == true &&
                              rollNo.isNotEmpty &&
                              name.isNotEmpty &&
                              password.isNotEmpty &&
                              fee.isNotEmpty &&
                              email.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Inserted Successsfully')));
                            setState(() {
                              isButtonActiveForName = false;
                              isButtonActiveForRollNo = false;
                              isButtonActiveForFee = false;
                              isButtonActiveForEmail = false;
                              isButtonActiveForPassword = false;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Insertion Failed')));
                          }
                          rollNoTextEditingController.clear();
                          emailTextEditingController.clear();
                          feeTextEditingController.clear();
                          nameTextEditingController.clear();
                          passwordTextEditingController.clear();
                        }
                      : null,
                  child: Container(
                    color: isButtonActiveForName &&
                            isButtonActiveForPassword &&
                            isButtonActiveForEmail &&
                            isButtonActiveForRollNo &&
                            isButtonActiveForFee
                        ? Colors.blue
                        : Colors.blue.shade100,
                    height: height * 0.1,
                    width: width * 0.8,
                    child: Center(
                      child: Text(
                        'Insert',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.15,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ViewStudentsScreen();
              },
            ));
          },
          label: Text('View'),
        ),
      ),
    );
  }
}
