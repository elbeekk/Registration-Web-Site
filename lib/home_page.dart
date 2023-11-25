import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reg_web_page/admin_page.dart';
import 'package:reg_web_page/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController surnameCon = TextEditingController();
  TextEditingController numberCon = TextEditingController();
  TextEditingController scoreCon = TextEditingController();
  TextEditingController scoreTypeCon = TextEditingController();
  TextEditingController curriculumCon = TextEditingController();

  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 6);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Birght Future'),
          centerTitle: true,
        ),
        body: Center(
            child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: padding,
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: nameCon,
                    autofillHints: const [AutofillHints.givenName],
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: const Text('Ism'),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                    ),
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: padding,
                  child: TextField(
                    autofillHints: const [AutofillHints.familyName],
                    textCapitalization: TextCapitalization.sentences,
                    controller: surnameCon,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: const Text('Familiya'),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                    ),
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: padding,
                  child: TextField(
                    autofillHints: const [AutofillHints.telephoneNumber],
                    textCapitalization: TextCapitalization.sentences,
                    controller: numberCon,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      label: const Text('Tel. raqam'),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                    ),
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: padding,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          controller: scoreCon,
                          onChanged: (value) {
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                setState(() {});
                              },
                            );
                          },
                          decoration: InputDecoration(
                            label: const Text('Natija'),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownMenu(
                          controller: scoreTypeCon,
                          inputDecorationTheme: const InputDecorationTheme(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                          requestFocusOnTap: false,
                          initialSelection: 'ielts',
                          dropdownMenuEntries: [
                            const DropdownMenuEntry(
                                value: 'topic', label: 'TOPIC'),
                            const DropdownMenuEntry(
                                value: 'ielts', label: 'IELTS'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding.vertical),
                child: DropdownMenu(
                    controller: curriculumCon,
                    initialSelection: 'bakalavr',
                    requestFocusOnTap: false,
                    label: Text(
                      'Dastur turi',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.primary)),
                    ),
                    width: MediaQuery.sizeOf(context).width < 500
                        ? MediaQuery.sizeOf(context).width - padding.horizontal
                        : 500 - padding.horizontal,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'bakalavr', label: 'Bakalavr'),
                      DropdownMenuEntry(
                          value: 'magistr', label: 'Magistratura'),
                    ]),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: padding,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: Colors.blueGrey.shade100,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: (numberCon.text.isNotEmpty &&
                                  nameCon.text.isNotEmpty &&
                                  surnameCon.text.isNotEmpty &&
                                  scoreCon.text.isNotEmpty)
                              ? () {
                                  bool isAdmin = nameCon.text.trim()=='admin'&&surnameCon.text=='admin'&&numberCon.text=='123'&&scoreCon.text=='1';
                                  if(isAdmin){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage(),));
                                      }else{
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc()
                                        .set({
                                      "first_name": nameCon.text.trim(),
                                      "last_name": surnameCon.text.trim(),
                                      "phone_number": numberCon.text.trim(),
                                      "certificate": {
                                        "type": scoreTypeCon.text,
                                        "score": scoreCon.text.trim(),
                                      },
                                      "curriculum": curriculumCon.text,
                                      "date": DateTime.now()
                                    }).whenComplete(() {
                                      nameCon.clear();
                                      surnameCon.clear();
                                      numberCon.clear();
                                      scoreCon.clear();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content:
                                          Center(child: Text('Muvaffaqiyatli yuborildi!')),
                                          backgroundColor: Colors.green.shade300,
                                        ),
                                      );
                                    });
                                  }
                                }
                              : null,
                          child: const Text('Yuborish'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}