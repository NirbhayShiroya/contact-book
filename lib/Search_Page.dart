import 'package:contact_book/AllDetail.dart';
import 'package:contact_book/HomePage.dart';
import 'package:flutter/material.dart';

class Search_page extends StatefulWidget {
  List l;

  Search_page(this.l);

  @override
  State<Search_page> createState() => _Search_pageState();
}

class _Search_pageState extends State<Search_page> {
  List l = [];
  List newlist = [];
  TextEditingController search = TextEditingController();
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    l = widget.l;

    for (int i = 0; i < l.length; i++) {
      newlist.add(l[i]['fname']);
      print(newlist);
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      items = newlist
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchBar(
              controller: search,
              leading: IconButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                },));
              }, icon: Icon(Icons.arrow_back)),
              onChanged: (value) {
                filterSearchResults(value);
              },
              hintText: "search hear",
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: items.length,
            //     itemBuilder: (context, index) {
            //       return  Text(items[index]);
            //     },
            //   ),
            // ),
            search.text == ""
                ? Expanded(
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
                                        borderRadius:
                                            BorderRadius.circular(25)),
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
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AllDetail(l, index);
                                      },
                                    ));
                              },
                                child: Text(items[index])),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
