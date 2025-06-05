import 'dart:io';

import 'package:contact_book/AllDetail.dart';
import 'package:contact_book/HomePage.dart';
import 'package:contact_book/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'DBHelper.dart';

class upadate_record extends StatefulWidget {
  List l;
  int index1;

  upadate_record(this.l, this.index1);

  @override
  State<upadate_record> createState() => _upadate_recordState();
}

class _upadate_recordState extends State<upadate_record> {
  List l = [];
  int index1 = 0;
  List<bool> status = List.filled(3, false);
  List lsthobby = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    l = widget.l;
    index1 = widget.index1;

     String checkhobby = l[index1]['hobby'];

     lsthobby = checkhobby.split(",");  //convert String to list for select checkbox


    tfname.text = l[index1]['fname'];
    tmname.text = l[index1]['mname'];
    tlname.text = l[index1]['lname'];
    temail.text = l[index1]['email'];
    // tpass.text = l[index1]['password'];
    defualtcode = l[index1]['phonecode'];
    tmno.text = l[index1]['mno'];
    taddr.text = l[index1]['address'];
    tcity.text = l[index1]['city'];
    gv = l[index1]['gender'];


    for (int i = 0; i < status.length; i++)
  {
    if(lsthobby.contains(Utils.hobby[i]))
      {
       status[i]=true;
      }
  }
  }

  TextEditingController tfname = TextEditingController();
  TextEditingController tmname = TextEditingController();
  TextEditingController tlname = TextEditingController();
  TextEditingController temail = TextEditingController();
  // TextEditingController tpass = TextEditingController();
  TextEditingController tmno = TextEditingController();
  TextEditingController taddr = TextEditingController();
  TextEditingController tcity = TextEditingController();

  String? errfname;

  // String? errlname;
  String? erremail;
  // String? errpass;
  String? errmno;

  // String? erraddr;
  // String? errcity;

//   String passCondition = """Minimum 1 Upper case
// Minimum 1 lowercase
// Minimum 1 Numeric Number
// Minimum 1 Special Character
// Common Allow Character ( ! @ # \$ & * ~ ) """;

  String gv = " ";
  // bool passtatus = true;

  List contryPhcode = [
    "+91",
    "+1",
    "+44",
    "+52",
    "+86"
  ];

  String defualtcode = "+91";

  List<DropdownMenuItem> phonecode() {
    List<DropdownMenuItem> phonecode = [];

    for (int i = 0; i < contryPhcode.length; i++) {
      phonecode.add(
        DropdownMenuItem(
          value: contryPhcode[i],
          child: Text("${contryPhcode[i]}"),
        ),
      );
    }
    return phonecode;
  }

  Future<bool> backbutton() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return AllDetail(l, index1);
      },
    ));

    return Future.value();
  }

  File? image;

  Future pickImagegallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImagecamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget imagedialoge() {
    return SimpleDialog(
      insetPadding: EdgeInsets.all(100),
      children: [
        Row(
          children: [
            Column(
              children: [
                InkWell(
                  child: Icon(Icons.camera_alt_rounded, size: 40),
                  onTap: () {
                    pickImagecamera();
                    Navigator.pop(context);
                  },
                ),
                Text("Camera"),
              ],
            ),
            Column(
              children: [
                InkWell(
                  child: Icon(Icons.image_rounded, size: 40),
                  onTap: () {
                    pickImagegallery();
                    Navigator.pop(context);
                  },
                ),
                Text("Gallery"),
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backbutton,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
               return AllDetail(l, index1);
             },));
            },
            icon: Icon(Icons.close_outlined, color: Colors.black),
          ),
          leadingWidth: 30,
          elevation: 0,
          title: Text("Create contact",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              )),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF465D91)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    String fname = tfname.text;
                    String mname = tmname.text;
                    String lname = tlname.text;
                    String email = temail.text;
                    // String pass = tpass.text;
                    String phcode = defualtcode;
                    String contactno = tmno.text;
                    String address = taddr.text;
                    String city = tcity.text;
                    String gender = gv;

                    setState(() {
                      errfname = null;
                      // errlname = null;
                      erremail = null;
                      // errpass = null;
                      errmno = null;
                      // erraddr = null;
                      // errcity = null;
                    });

                    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+[a-zA-Z]+")
                        .hasMatch(temail.text);

                    // final bool passValid = RegExp(
                    //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                    //     .hasMatch(tpass.text);

                    if (tfname.text.isEmpty) {
                      setState(() {
                        errfname = "Enter First name";
                      });
                    }
                    // else if (tlname.text.isEmpty) {
                    //   setState(() {
                    //     errlname = "Enter Last name";
                    //   });
                    // }
                    // else if (temail.text.isEmpty) {
                    //   setState(() {
                    //     erremail = "Enter Email";
                    //   });
                    // } else if (emailValid == false) {
                    //   setState(() {
                    //     erremail = "Enter valid Email";
                    //   });
                    // }
                    else if (tmno.text.isEmpty) {
                      setState(() {
                        errmno = "Enter Mobil no.";
                      });
                    } else if (tmno.text.length < 10) {
                      setState(() {
                        errmno = "Atlist 10 number requried";
                      });
                    }
                    // else if (tpass.text.isEmpty) {
                    //   setState(() {
                    //     errpass = "Enter Password";
                    //   });
                    // } else if (tpass.text.length < 8) {
                    //   setState(() {
                    //     errpass = "Enter minimum 8 character";
                    //   });
                    // } else if (passValid == false) {
                    //   setState(() {
                    //     errpass = "Make stronger password \n\n$passCondition";
                    //   });
                    // }
                    // else if (taddr.text.isEmpty) {
                    //   setState(() {
                    //     erraddr = "Enter Address";
                    //   });
                    // } else if (tcity.text.isEmpty) {
                    //   setState(() {
                    //     errcity = "Enter city";
                    //   });
                    // }
                    // else if (gv == " ") {
                    //   const snackBar = SnackBar(
                    //     backgroundColor: Color(0xFF465D91),
                    //     margin: EdgeInsets.all(10),
                    //     behavior: SnackBarBehavior.floating,
                    //     content: Text('please select Gender'),
                    //   );
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // } else if (chkreading == false &&
                    //     chkwriting == false &&
                    //     chktravling == false) {
                    //   const snackBar = SnackBar(
                    //     backgroundColor: Color(0xFF465D91),
                    //     margin: EdgeInsets.all(10),
                    //     behavior: SnackBarBehavior.floating,
                    //     content: Text('please select Hobby'),
                    //   );
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // }
                    else {

                      int id = l[index1]['id'];
                      String strhobby = lsthobby.join(",");
                      print(lsthobby);

                      String qry =
                      "update contactinfo set fname='$fname',mname='$mname',lname='$lname',email='$email',phonecode='$phcode',mno='$contactno',address='$address',city='$city',gender='$gender',hobby='$strhobby' where id = $id";
                      int a = await DBHelper.database!.rawUpdate(qry);

                      if (a > 0) {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.white,
                          margin: EdgeInsets.all(20),
                          behavior: SnackBarBehavior.floating,
                          content: Row(
                            children: [
                              Icon(Icons.check, color: Colors.green),
                              Text(
                                "   Contact updated",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));
                      } else {
                        const snackBar = SnackBar(
                            backgroundColor: Colors.white,
                            margin: EdgeInsets.all(20),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Error: contact not updated",
                              style: TextStyle(color: Colors.red),
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Text(
                    "update",
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return imagedialoge();
                      },
                    );
                  },
                  child: image == null
                      ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Color(0xFFDCE2FA),
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 40,
                      ))
                      : Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color(0xFFDCE2FA),
                        image: DecorationImage(
                            image: FileImage(image!), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return imagedialoge();
                        },
                      );
                    },
                    child: Text("Add picture",
                        style: TextStyle(color: Color(0xFF485D8D))),
                  ),
                ),
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 20, 8),
                          child: Icon(Icons.person_outline_outlined, size: 30),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextField(
                              controller: tfname,
                              decoration: InputDecoration(
                                  errorText: errfname,
                                  border: OutlineInputBorder(),
                                  labelText: "First name*",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF465D91), width: 2))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(66, 10, 52, 0),
                        child: TextField(
                          controller: tmname,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Middle name",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF465D91), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(66, 10, 55, 0),
                  child: TextField(
                    controller: tlname,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Last name",
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF465D91), width: 2),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 15, 20, 8),
                      child: Icon(Icons.email_outlined, size: 30),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 55, 0),
                        child: TextField(
                          controller: temail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            suffix: Text("@gmail.com"),
                            errorText: erremail,
                            border: OutlineInputBorder(),
                            labelText: "Enter Email*",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF465D91), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 20, 8),
                      child: Icon(Icons.phone, size: 30),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 8, 12),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black38),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        value: defualtcode,
                        style: TextStyle(fontSize: 10, color: Colors.black),
                        items: phonecode(),
                        onChanged: (value) {
                          setState(() {
                            defualtcode = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 55, 0),
                        child: TextField(
                          controller: tmno,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: InputDecoration(
                            errorText: errmno,
                            border: OutlineInputBorder(),
                            labelText: "Enter Mobil no.*",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF465D91), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.fromLTRB(16, 0, 20, 66),
                //       child: Icon(Icons.password_outlined, size: 30),
                //     ),
                //     Expanded(
                //       child: Padding(
                //         padding: const EdgeInsets.fromLTRB(0, 10, 55, 0),
                //         child: TextField(
                //           readOnly: true,
                //           controller: tpass,
                //           obscureText: passtatus,
                //           decoration: InputDecoration(
                //             helperText: passCondition,
                //             errorText: errpass,
                //             border: OutlineInputBorder(),
                //             suffixIcon: IconButton(
                //                 onPressed: () {
                //                   setState(() {
                //                     if (passtatus == true) {
                //                       passtatus = false;
                //                     } else {
                //                       passtatus = true;
                //                     }
                //                   });
                //                 },
                //                 icon: passtatus
                //                     ? Icon(
                //                         Icons.visibility,
                //                         color: Colors.black,
                //                       )
                //                     : Icon(
                //                         Icons.visibility_off,
                //                         color: Colors.black,
                //                       )),
                //             labelText: "Enter Password*",
                //             focusedBorder: OutlineInputBorder(
                //               borderSide: BorderSide(
                //                   color: Color(0xFF465D91), width: 2),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 20, 8),
                      child: Icon(Icons.home, size: 30),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 55, 0),
                        child: TextField(
                          controller: taddr,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter Address",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF465D91), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 20, 8),
                      child: Icon(Icons.location_city_outlined, size: 30),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 55, 0),
                        child: TextField(
                          controller: tcity,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter city",
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF465D91), width: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 200,
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gender :",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              RadioListTile(
                                contentPadding: EdgeInsets.only(right: 8),
                                title: Text("Male"),
                                value: "Male",
                                groupValue: gv,
                                onChanged: (value) {
                                  setState(() {
                                    gv = value!;
                                  });
                                },
                              ),
                              RadioListTile(
                                contentPadding: EdgeInsets.only(right: 8),
                                title: Text("Female"),
                                value: "Female",
                                groupValue: gv,
                                onChanged: (value) {
                                  setState(() {
                                    gv = value!;
                                  });
                                },
                              ),
                              RadioListTile(
                                contentPadding: EdgeInsets.only(right: 8),
                                title: Text("other"),
                                value: "other",
                                groupValue: gv,
                                onChanged: (value) {
                                  setState(() {
                                    gv = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 200,
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hobby :",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.only(right: 8),
                                controlAffinity:
                                ListTileControlAffinity.leading,
                                title: Text(Utils.hobby[0]),
                                value: status[0],
                                onChanged: (value) {
                                  setState(() {
                                    status[0] = value!;
                                    if (value == true) {
                                      lsthobby.add(Utils.hobby[0]);
                                    } else {
                                      lsthobby.remove(Utils.hobby[0]);
                                    }
                                    print(lsthobby);
                                  });
                                },
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.only(right: 8),
                                controlAffinity:
                                ListTileControlAffinity.leading,
                                title: Text(Utils.hobby[1]),
                                value: status[1],
                                onChanged: (value) {
                                  setState(() {
                                    status[1] = value!;
                                    if (value == true) {
                                      lsthobby.add(Utils.hobby[1]);
                                    } else {
                                      lsthobby.remove(Utils.hobby[1]);
                                    }
                                    print(lsthobby);
                                  });
                                },
                              ),
                              CheckboxListTile(
                                contentPadding: EdgeInsets.only(right: 8),
                                controlAffinity:
                                ListTileControlAffinity.leading,
                                title: Text(Utils.hobby[2]),
                                value: status[2],
                                onChanged: (value) {
                                  setState(() {
                                    status[2] = value!;
                                    if (value == true) {
                                      lsthobby.add(Utils.hobby[2]);
                                    } else {
                                      lsthobby.remove(Utils.hobby[2]);
                                    }
                                    print(lsthobby);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
