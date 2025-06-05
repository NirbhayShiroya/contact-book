import 'package:contact_book/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Update_page.dart';

class AllDetail extends StatefulWidget {


  List l;
  int index1;

  AllDetail(this.l, this.index1);

  @override
  State<AllDetail> createState() => _AllDetailState();
}

class _AllDetailState extends State<AllDetail> {
  List l = [];
  int index1 = 0;
  String? action;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    l = widget.l;
    index1 = widget.index1;

  }


  Future<bool> backbutton() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return HomePage();
      },
    ));
    return Future.value();
  }

  _callNumber() async {
     String number = "${l[index1]['mno']}"; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ));
            },
            icon: Icon(Icons.arrow_back_outlined),
            color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return upadate_record(l, index1);
                  },
                ));
              },
              icon: Icon(
                Icons.edit_outlined,
                color: Colors.black,
              )),
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.star_border_outlined,
          //       color: Colors.black,
          //     )),
          // PopupMenuButton(
          //   color: Color(0xFFE9ECF6),
          //   tooltip: "Menu",
          //   position: PopupMenuPosition.over,
          //   icon: Icon(
          //     Icons.more_vert_outlined,
          //     color: Colors.black,
          //   ),
          //   itemBuilder: (context) {
          //     return [
          //       PopupMenuItem(child: Text("Delete")),
          //       PopupMenuItem(child: Text("Share"))
          //     ];
          //   },
          // ),
        ],
      ),
      body: WillPopScope(
        onWillPop: backbutton,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(30),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                      child:
                      Text(
                    l[index1]['fname'][0].toUpperCase(),
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                  ),
                ),
              ),
              Text(
                "${l[widget.index1]["fname"]}",
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 17),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black12))),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: myRow(),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                    color: Color(0xFFE0E4F5),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact info",
                        style: TextStyle(fontSize: 15),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: IconButton(
                                    iconSize: 25,
                                    onPressed: () {},
                                    icon: Icon(Icons.call_outlined)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${l[index1]['phonecode']}${' ' + l[index1]['mno']}",
                                      style: TextStyle(fontSize: 15)),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text("Phone"),
                                  ),
                                ],
                              ),
                              Spacer(),
                              // IconButton(
                              //     iconSize: 27,
                              //     onPressed: () {},
                              //     icon: Icon(Icons.videocam_outlined)),
                              IconButton(
                                  iconSize: 22,
                                  onPressed: () {
                                  },
                                  icon: Icon(Icons.message_outlined)),
                            ],
                          ),
                        ),
                      ),
                      l[index1]['email'] != ""
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      iconSize: 25,
                                      onPressed: () async {

                                      },
                                      icon: Icon(Icons.email_outlined)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(l[index1]['email'],
                                        style: TextStyle(fontSize: 15)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text("Mobile"),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              l[index1]['address'] != "" ||
                      l[index1]['city'] != "" ||
                      l[index1]['gender'] != "" ||
                      l[index1]['hobby'] != ""
                  ? Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                          color: Color(0xFFE0E4F5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About${' ' + l[index1]['fname']}",
                              style: TextStyle(fontSize: 15),
                            ),
                            l[index1]['address'] != ""
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: IconButton(
                                              iconSize: 25,
                                              onPressed: () {},
                                              icon: Icon(Icons.home)),
                                        ),
                                        Text(l[index1]['address'],
                                            style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                  )
                                : Container(),
                            l[index1]['city'] != ""
                                ? Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: IconButton(
                                            iconSize: 25,
                                            onPressed: () {},
                                            icon: Icon(
                                                Icons.location_city_outlined)),
                                      ),
                                      Text(l[index1]['city'],
                                          style: TextStyle(fontSize: 15)),
                                    ],
                                  )
                                : Container(),
                            l[index1]['gender'] != ""
                                ? Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: IconButton(
                                            iconSize: 25,
                                            onPressed: () {},
                                            icon: Icon(
                                                Icons.transgender_outlined)),
                                      ),
                                      Text(l[index1]['gender'],
                                          style: TextStyle(fontSize: 15)),
                                    ],
                                  )
                                : Container(),
                            l[index1]['hobby'] != ""
                                ? Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: IconButton(
                                            iconSize: 25,
                                            onPressed: () {},
                                            icon: Icon(Icons.ac_unit)),
                                      ),
                                      Text(l[index1]['hobby'],
                                          style: TextStyle(fontSize: 15)),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> myRow() {
    List<Widget> list = [];

    list.add(Column(
      children: [
        IconButton(
            iconSize: 25,
            color: Color(0xFF485D8D),
            onPressed:_callNumber,
            icon: Icon(Icons.call_outlined)),
        Text(
          "Call",
          style: TextStyle(color: Color(0xFF485D8D), fontSize: 14),
        ),
      ],
    ));

    list.add(Column(
      children: [
        IconButton(
            iconSize: 25,
            color: Color(0xFF485D8D),
            onPressed: () async {
              String getnumber = l[index1]['mno'];
              final url = Uri.parse('sms:$getnumber');
              if (await canLaunchUrl(url)) {
              await launchUrl(url);
              } else {
              throw 'Could not launch $url';
              }


            },
            icon: Icon(Icons.message_outlined)),
        Text(
          "Text",
          style: TextStyle(color: Color(0xFF485D8D), fontSize: 14),
        ),
      ],
    ));

    // list.add(Column(
    //   children: [
    //     IconButton(
    //         iconSize: 30,
    //         color: Color(0xFF485D8D),
    //         onPressed: () {},
    //         icon: Icon(Icons.videocam_outlined)),
    //     Text(
    //       "Video",
    //       style: TextStyle(color: Color(0xFF485D8D), fontSize: 14),
    //     ),
    //   ],
    // ));

    if (l[index1]['email'] != "") {
      list.add(Column(
        children: [
          IconButton(
              iconSize: 25,
              color: Color(0xFF485D8D),
              onPressed: () async {
                String getemail = l[index1]['email'];
                final url = Uri.parse(
                    'mailto:$getemail?subject=Test&body=Test email');
                if (await canLaunchUrl(url)) {
                await launchUrl(url);
                } else {
                throw 'Could not launch $url';
                }
              },
              icon: Icon(Icons.email_outlined)),
          Text(
            "Email",
            style: TextStyle(color: Color(0xFF485D8D), fontSize: 14),
          ),
        ],
      ));
    }
    return list;
  }
}
