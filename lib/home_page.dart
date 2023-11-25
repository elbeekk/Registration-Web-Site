import 'dart:html';

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
  TextEditingController cityCon = TextEditingController();
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 6);
  bool isAdmin = false;
  checkAdmin() async {
    String? isAdm = window.localStorage['login'];
    isAdmin = bool.parse(isAdm??"false");
    setState(() {});
  }

  @override
  void dispose() {
    nameCon.dispose();
    surnameCon.dispose();
    numberCon.dispose();
    scoreCon.dispose();
    super.dispose();
  }

    @override
  void initState() {
    checkAdmin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    checkAdmin();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text('Bright Future',style: TextStyle(color: AppColors.primary),),
        //   centerTitle: true,
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        // ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
              child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      height: MediaQuery.sizeOf(context).height*0.26,
                      child: Image.asset('assets/logo.jpg',fit: BoxFit.fitHeight,)),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: padding.vertical),
                  child: DropdownMenu(
                      controller: cityCon,
                      initialSelection: 'toshkent',
                      requestFocusOnTap: false,
                      label: Text(
                        'Viloyat',
                        style: TextStyle(color: AppColors.primary),
                      ),
                      width: MediaQuery.sizeOf(context).width < 500
                          ? MediaQuery.sizeOf(context).width - padding.horizontal
                          : 500 - padding.horizontal,
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
                        DropdownMenuEntry(value: 'jizzax', label: 'Jizzax'),
                        DropdownMenuEntry(value: 'andrijon', label: 'Andijon'),
                        DropdownMenuEntry(value: 'namangan', label: 'Namangan'),
                        DropdownMenuEntry(value: 'farg\'ona', label: 'Farg\'ona'),
                        DropdownMenuEntry(value: 'sirdaryo', label: 'Sirdaryo'),
                        DropdownMenuEntry(value: 'toshkent', label: 'Toshkent'),
                        DropdownMenuEntry(value: 'qashqadaryo', label: 'Qashqadaryo'),
                        DropdownMenuEntry(value: 'surxondaryo', label: 'Surxondaryo'),
                        DropdownMenuEntry(value: 'buxoro', label: 'Buxoro'),
                        DropdownMenuEntry(value: 'navoiy', label: 'Navoiy'),
                        DropdownMenuEntry(value: 'xorazm', label: 'Xorazm'),
                        DropdownMenuEntry(value: 'qoraqalpog\'iston', label: 'Qoraqalpog\'iston'),
                      ]),
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
                                  value: 'topik', label: 'TOPIK'),
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
                            value: 'magistratura', label: 'Magistratura'),
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
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.button,
                                disabledBackgroundColor: Colors.blueGrey.shade100,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: (numberCon.text.isNotEmpty &&
                                    nameCon.text.isNotEmpty &&
                                    surnameCon.text.isNotEmpty &&
                                    scoreCon.text.isNotEmpty)
                                ? () async {
                                    bool isAdmin1 = nameCon.text.trim()=='admin'&&surnameCon.text=='admin'&&numberCon.text=='123'&&scoreCon.text=='1';
                                    if(isAdmin1){
                                      window.localStorage['login'] = 'true';
                                      isAdmin=true;
                                      nameCon.clear();
                                      surnameCon.clear();
                                      numberCon.clear();
                                      scoreCon.clear();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminPage(),));
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
                                        "city": cityCon.text,
                                        "date": DateTime.now()
                                      }).whenComplete(() {
                                        nameCon.clear();
                                        surnameCon.clear();
                                        numberCon.clear();
                                        scoreCon.clear();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content:
                                            const Center(child: Text('Muvaffaqiyatli yuborildi!')),
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
                ),
                if(isAdmin)Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: padding,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.button,
                                disabledBackgroundColor: Colors.green.shade100,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminPage(),));
                            },
                            child: const Text('Admin bo\'lib kirish'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
