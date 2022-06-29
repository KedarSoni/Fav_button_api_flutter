import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Fav extends StatefulWidget {
  List<bool> heart;
  List lst;
  Fav({
    Key? key,
    required this.heart,
    required this.lst,
  }) : super(key: key);

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  @override
  void initState() {
    getList(widget.heart, widget.lst);
    super.initState();
  }

  late List<bool> isCheck;
  List? abc;

  getList(List<bool> id, List lst) {
    isCheck = id;
    abc = lst;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourites List')),
      body: Center(
        // child: GridView.count(
        //     crossAxisCount: 3,
        //     crossAxisSpacing: 4.0,
        //     mainAxisSpacing: 8.0,
        //     children: List.generate(abc!.length, (index) {
        //       return Expanded(
        //         child: Padding(
        //           padding: const EdgeInsets.all(0.0),
        //           child: isCheck[index] == false
        //               ? GridTile(
        //                   header: Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: CircleAvatar(
        //                       radius: 30,
        //                       foregroundImage:
        //                           NetworkImage(abc![index]['avatar']),
        //                     ),
        //                   ),
        //                   child: Center(child: Text(abc![index]['first_name'])),
        //                   footer: IconButton(
        //                     icon: Icon(Icons.remove_circle_outline),
        //                     onPressed: () {
        //                       setState(() {
        //                         isCheck[index] = !isCheck[index];
        //                       });
        //                     },
        //                   ),
        //                 )
        //               : null,
        //         ),
        //       );
        //     })),

        child: ListView.builder(
            itemCount: abc!.length,
            itemBuilder: (builder, index) {
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: isCheck[index] == false
                    ? Card(
                        child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 30,
                            foregroundImage:
                                NetworkImage(abc![index]['avatar']),
                          ),
                        ),
                        title: Text(abc![index]['first_name']),
                        subtitle: Text(abc![index]['email']),
                        trailing: IconButton(
                          icon: Icon(
                            CupertinoIcons.delete_solid,
                            color: Color.fromARGB(255, 4, 3, 9),
                          ),
                          onPressed: () {
                            setState(() {
                              isCheck[index] = !isCheck[index];
                            });
                          },
                        ),
                      ))
                    : null,
              );
            }),
      ),
    );
  }
}
