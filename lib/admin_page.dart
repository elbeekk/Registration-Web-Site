import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reg_web_page/user_model.dart';

import 'constants.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isDownloading = false;
  bool isEmpty = true;
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6);
  TextEditingController nameCon = TextEditingController();
  TextEditingController surnameCon = TextEditingController();
  TextEditingController numberCon = TextEditingController();
  TextEditingController scoreCon = TextEditingController();
  TextEditingController scoreTypeCon = TextEditingController();
  TextEditingController curriculumCon = TextEditingController();

  downloadTable() async {
    setState(() {
      isDownloading = true;
    });
    Excel excel = Excel.createExcel();
    excel.appendRow('users', [
      '№',
      'First Name',
      'Last Name',
      'Phone Number',
      'Certificate Type',
      'Certificate Score',
      'Curriculum',
      'Date',
    ]);
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      List listOfUsers = (value.docs.map((element) {
        return UserModel.fromJson(element.data()).toRawJson();
      })).toList();
      for (var i in value.docs) {
        UserModel userm = UserModel.fromJson(i.data());
        excel.appendRow('users', [
          ((listOfUsers.indexOf(userm.toRawJson()) ?? 0) + 1).toString(),
          userm.firstName,
          userm.lastName,
          userm.phoneNumber,
          userm.certificate.type,
          userm.certificate.score,
          userm.curriculum,
          userm.date.toDate().toString().split('.')[0]
        ]);
      }
    }).whenComplete(() {
      setState(() {
        isDownloading = false;
      });
      return excel.save(fileName: 'users.xlsx');
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    if (isEmpty) {
      Timer.periodic(const Duration(milliseconds: 500), (timer) async {
        await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((value) {
          if (value.docs.isEmpty) {
            isEmpty = true;
          } else {
            isEmpty = false;
            setState(() {});
          }
        });
      });
    }else{
      await FirebaseFirestore.instance.collection('users').get().then((value){
        if(value.docs.isEmpty){
          isEmpty=true;
        }else{
          isEmpty=false;
        }
      });
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext conSelectableText) {
    getData();
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              nameCon.clear();
              surnameCon.clear();
              scoreCon.clear();
              numberCon.clear();
              showAddDialog();
            },
            backgroundColor: Colors.green.shade300,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: Object(),
            onPressed: () {
              downloadTable();
            },
            backgroundColor: Colors.green.shade300,
            child: isDownloading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: !isEmpty ? StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (BuildContext conSelectableText, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              List? listOfUsers = (snapshot.data?.docs.map((element) {
                return UserModel.fromJson(element.data()).toRawJson();
              }))?.toList();
              log("${listOfUsers?[0]}");
              log("${listOfUsers?.length.toString()}");
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(color: Colors.black, width: 0.2),
                  children: [
                    TableRow(
                        decoration: BoxDecoration(color: Colors.green.shade100),
                        children: const [
                          Column(
                            children: [
                              SelectableText('№'),
                            ],
                          ),
                          Column(
                            children: [
                              SelectableText('First Name'),
                            ],
                          ),
                          Column(
                            children: [
                              SelectableText('Last Name'),
                            ],
                          ),
                          Column(
                            children: [
                              SelectableText('Phone Number'),
                            ],
                          ),
                          Column(
                            children: [
                              SelectableText('Certificate Type'),
                            ],
                          ),
                          Column(
                            children: [
                              SelectableText('Certificate Score'),
                            ],
                          ),
                          Column(
                            children: [
                              SelectableText('Curriculum'),
                            ],
                          ),
                          Column(
                            children: [
                              SelectableText('Date'),
                            ],
                          ),Column(
                            children: [
                              SelectableText(''),
                            ],
                          ),
                        ]),
                    ...?snapshot.data?.docs.map((e) {
                      UserModel usermodel = UserModel.fromJson(e.data());
                      return TableRow(children: [
                        Column(
                          children: [
                            SelectableText(
                                ((listOfUsers?.indexOf(usermodel.toRawJson()) ??
                                            0) +
                                        1)
                                    .toString()),
                          ],
                        ),
                        Column(
                          children: [
                            SelectableText(usermodel.firstName),
                          ],
                        ),
                        Column(
                          children: [
                            SelectableText(usermodel.lastName),
                          ],
                        ),
                        Column(
                          children: [
                            SelectableText(usermodel.phoneNumber),
                          ],
                        ),
                        Column(
                          children: [
                            SelectableText(usermodel.certificate.type),
                          ],
                        ),
                        Column(
                          children: [
                            SelectableText(usermodel.certificate.score),
                          ],
                        ),
                        Column(
                          children: [
                            SelectableText(usermodel.curriculum),
                          ],
                        ),
                        Column(
                          children: [
                            SelectableText(usermodel.date
                                .toDate()
                                .toString()
                                .split('.')[0]),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                numberCon.text = usermodel.phoneNumber;
                                nameCon.text = usermodel.firstName;
                                surnameCon.text = usermodel.lastName;
                                scoreCon.text = usermodel.certificate.score;
                                showEditDialog(usermodel,e.id);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Icon(Icons.edit,size: 15,color: Colors.blue,)
                              ],),
                            )
                          ],
                        ),
                      ]);
                    }),
                  ],
                ),
              );
            }
            return Center(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.45),
                child: const SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              ),
            );
          },
        ):Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: Lottie.asset('assets/empty.json')),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAddDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            scrollable: true,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.zero,
            content: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
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
                    padding: padding,
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
                                  disabledBackgroundColor:
                                  Colors.blueGrey.shade100,
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: (numberCon.text.isNotEmpty &&
                                  nameCon.text.isNotEmpty &&
                                  surnameCon.text.isNotEmpty &&
                                  scoreCon.text.isNotEmpty)
                                  ? () {
                                bool isAdmin =
                                    nameCon.text.trim() == 'admin' &&
                                        surnameCon.text == 'admin' &&
                                        numberCon.text == '123' &&
                                        scoreCon.text == '1';
                                if (isAdmin) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AdminPage(),
                                      ));
                                } else {
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
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: const Center(
                                            child: Text(
                                                'Muvaffaqiyatli qo\'shildi!')),
                                        backgroundColor:
                                        Colors.green.shade300,
                                      ),
                                    );
                                  });
                                }
                              }
                                  : null,
                              child: const Text('Qo\'shish'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },);
      },
    );
  }
  Future<dynamic> showEditDialog(UserModel userModel,String docId) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            scrollable: true,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.zero,
            content: AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
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
                              initialSelection: userModel.certificate.type.toLowerCase(),
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
                    padding: padding,
                    child: DropdownMenu(
                        controller: curriculumCon,
                        initialSelection: userModel.curriculum.toLowerCase(),
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
                                  disabledBackgroundColor:
                                  Colors.blueGrey.shade100,
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: (numberCon.text.isNotEmpty &&
                                  nameCon.text.isNotEmpty &&
                                  surnameCon.text.isNotEmpty &&
                                  scoreCon.text.isNotEmpty)
                                  ? () {
                                bool isAdmin =
                                    nameCon.text.trim() == 'admin' &&
                                        surnameCon.text == 'admin' &&
                                        numberCon.text == '123' &&
                                        scoreCon.text == '1';
                                if (isAdmin) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AdminPage(),
                                      ));
                                } else {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(docId)
                                      .set({
                                    "first_name": nameCon.text.trim(),
                                    "last_name": surnameCon.text.trim(),
                                    "phone_number": numberCon.text.trim(),
                                    "certificate": {
                                      "type": scoreTypeCon.text,
                                      "score": scoreCon.text.trim(),
                                    },
                                    "curriculum": curriculumCon.text,
                                    "date": userModel.date.toDate()
                                  }).whenComplete(() {
                                    nameCon.clear();
                                    surnameCon.clear();
                                    numberCon.clear();
                                    scoreCon.clear();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: const Center(
                                            child: Text(
                                                'Muvaffaqiyatli saqlandi!')),
                                        backgroundColor:
                                        Colors.green.shade300,
                                      ),
                                    );
                                  });
                                }
                              }
                                  : null,
                              child: const Text('Saqlash'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },);
      },
    );
  }
}
