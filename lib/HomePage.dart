import 'dart:io';

import 'package:contact_book/AllDetail.dart';
import 'package:contact_book/DBHelper.dart';
import 'package:contact_book/FormPage.dart';
import 'package:flutter/material.dart';

import 'Search_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool status = false;
  bool contastatus = true;

  TextEditingController search = TextEditingController();
  GlobalKey<ScaffoldState> globalKey =GlobalKey<ScaffoldState>();

  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlldata();
  }

  getAlldata() async {
    String qry = "select * from contactinfo";

    List a = await DBHelper.database!.rawQuery(qry);
    l.addAll(a);
    setState(() {
      status = true;
    });

    print(l);
  }

  Future<bool> backbutton() {
   exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backbutton,
      child: Scaffold(
        key: globalKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return FormPage();
              },
            ));
          },
          child: Icon(Icons.add),
        ),
        body: status
            ? SafeArea(
              child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return Search_page(l);
                          },
                        ));
                        setState(() {
                          contastatus = false;
                        });
                      },
                      child:
                      // contastatus
                      //     ?
                      Container(
                              margin: EdgeInsets.all(20),
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFFE0E4F5),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "Search contacts",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          // : Container(
                          //     decoration: BoxDecoration(
                          //         border: Border(bottom: BorderSide(width: 0.5))),
                          //     padding: EdgeInsets.all(5),
                          //     child: TextField(
                          //       controller: search,
                          //       onChanged: (value) {
                          //         for (int i = 0; i < l.length; i++) {
                          //           if (search.text == l[i]['fname']) {
                          //             print("ok");
                          //           } else {
                          //             print("cancel");
                          //           }
                          //         }
                          //       },
                          //       decoration: InputDecoration(
                          //         border: InputBorder.none,
                          //         prefixIcon: IconButton(
                          //             onPressed: () {
                          //               setState(() {
                          //                 contastatus = true;
                          //                 search.text = "";
                          //               });
                          //             },
                          //             icon: Icon(
                          //               Icons.arrow_back_outlined,
                          //               color: Colors.black,
                          //             )),
                          //         hintText: "Search contacts",
                          //         suffixIcon: IconButton(
                          //           onPressed: () {},
                          //           icon: Icon(
                          //             Icons.keyboard_voice_outlined,
                          //             color: Colors.black,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: l.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return AllDetail(l, index);
                                },
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(25)),
                                    child: Center(
                                        child: Text(
                                      "${l[index]["fname"][0].toUpperCase()}",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    )),
                                  ),
                                  Text(
                                    "${l[index]['fname']}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Row(
                                                children: [
                                                  Icon(Icons.info_outline),
                                                  Text(" Warning")
                                                ],
                                              ),
                                              content: Text(
                                                  "Are you sure want to delete contact?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () async {
                                                      int id = l[index]['id'];
                                                      String qry =
                                                          "delete from contactinfo where id = $id";
                                                      await DBHelper.database!
                                                          .rawDelete(qry);
                                                      setState(() {
                                                        l.removeAt(index);
                                                      });

                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("yes")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("cancal")),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.delete_outline_outlined))
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
            )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
