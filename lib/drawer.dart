import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> items = [];

  TextEditingController editingController = TextEditingController();

  List<String> duplicateItems = [
    "Heet",
    "Jay",
    "Nikunj",
    "Nirbhay",
    "Het",
    "Pal",
    "Krish",
    "Avan",
    "Yatish",
    "Smit",
    "Parth",
    "Ravi"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items = duplicateItems;
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Column(
        children: [
          TextField(
            controller: editingController,
            onChanged: (value) {
              filterSearchResults(value);
            },
            decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Text(items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
