import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'favorites.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isLoading = false;
  List? lst;
  List<bool>? isChecked;
  int page = 1;
  int? tp;

  getData() async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
    var mapdata = json.decode(response.body);

    if (response.statusCode == 200) {
      lst = mapdata['data'];
      getFull();
      setState(() {
        isLoading = true;
        isChecked = List<bool>.filled(lst!.length, true);
      });
    }
    tp = mapdata['total_pages'];
  }

  getFull() async {
    do {
      page = page + 1;
      var response =
          await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
      var responsedata = json.decode(response.body);

      if (response.statusCode == 200) {
        lst = (lst! + responsedata['data']);

        setState(() {
          isChecked = List<bool>.filled(lst!.length, true);
        });
      }
    } while (page != tp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 50),
          child: isLoading
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: lst!.length,
                  itemBuilder: (context, position) {
                    return Builder(builder: (context) {
                      return Card(
                          child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                foregroundImage:
                                    NetworkImage(lst![position]['avatar']),
                              ),
                              title: Text(
                                'List Item $position',
                              ),
                              subtitle: Text(lst![position]['email']),
                              trailing: InkWell(
                                child: isChecked![position]
                                    ? Icon(CupertinoIcons.heart)
                                    : Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Color.fromARGB(255, 79, 35, 211),
                                      ),
                                onTap: () {
                                  setState(() {
                                    isChecked![position] =
                                        !isChecked![position];
                                  });
                                },
                              )));
                    });
                  })
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(CupertinoIcons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => Fav(heart: isChecked!, lst: lst!)))
                .then((value) {
              setState(() {});
            });
          }),
    );
  }
}
