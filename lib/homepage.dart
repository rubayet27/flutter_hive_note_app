import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/Model/data_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  late bool enabled;
  Box box = Hive.box('Note');
  @override
  Widget build(BuildContext context) {
    var sizH = MediaQuery.of(context).size.height;
    var sizW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Tracker App"),
      ),
      body: Row(children: [
        Drawer(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          width: sizW < 850 ? 60 : 250,
          backgroundColor: Color.fromARGB(255, 148, 148, 148),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                child: SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: sizW < 850
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: sizW > 850
                            ? const EdgeInsets.only(left: 10)
                            : EdgeInsets.zero,
                        child: const Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: sizW > 850
                            ? const EdgeInsets.only(left: 10)
                            : EdgeInsets.zero,
                        child: Text(
                          sizW > 850 ? "Home" : "",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              /*
              InkWell(
                child: SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: sizW < 850
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: sizW > 850
                            ? const EdgeInsets.only(left: 10)
                            : EdgeInsets.zero,
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: sizW > 850
                            ? const EdgeInsets.only(left: 10)
                            : EdgeInsets.zero,
                        child: Text(
                          sizW > 850 ? "Favourites" : "",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),*/
            ],
          ),
        ),
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Tasks To Do!",
                      style: TextStyle(fontSize: sizW < 600 ? 35 : 55),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 197, 196, 196),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 228, 227, 227),
                            borderRadius: BorderRadius.circular(15)),
                        child: Dismissible(
                          key: UniqueKey(),
                          background: Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Icon(Icons.thumb_up),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Mark as done!",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          onDismissed: ((DismissDirection direction) {
                            setState(() {
                              box.deleteAt(index);
                            });
                          }),
                          child: InkWell(
                            onDoubleTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: sizH * 0.5,
                                        width: sizW * 0.3,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25),
                                              child: Text(
                                                "${box.getAt(index).title}",
                                                style: const TextStyle(
                                                    fontSize: 25),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 40),
                                              child: SizedBox(
                                                height: sizH * 0.3,
                                                width: sizW * 0.3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Text(
                                                    "${box.getAt(index).description}",
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: ListTile(
                              title: Text(
                                "${box.getAt(index).title}",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ]),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: sizH * 0.5,
                  width: sizW * 0.3,
                  child: Column(
                    children: [
                      const Text(
                        "Add Task",
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: SizedBox(
                          height: 50,
                          width: sizW * 0.3,
                          child: TextField(
                            controller: title,
                            decoration: InputDecoration(
                                hintText: "Title",
                                labelText: "Title",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: sizW * 0.3,
                          child: TextField(
                            controller: description,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: "Description",
                              //labelText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              minimumSize: const Size(120, 50)),
                          onPressed: () {
                            var addData = DataModel(
                                title: title.text,
                                description: description.text);

                            setState(() {
                              box.add(addData);
                              title.clear();
                              description.clear();
                            });
                            Navigator.pop(context, false);
                          },
                          child: const Text("Add Task"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
