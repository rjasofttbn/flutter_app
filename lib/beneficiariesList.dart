import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/todo_model.dart';
import 'package:http/http.dart' as http;

class BeneficiaryList extends StatefulWidget {
  const BeneficiaryList({super.key});

  @override
  State<BeneficiaryList> createState() => BeneficiaryListState();
}

class BeneficiaryListState extends State<BeneficiaryList> {
  final TodoModel todoModel = TodoModel();
  List<TodoModel> todoModelList = <TodoModel>[];
  var isCheck = false;
  // List data show
  Future<List<TodoModel?>> BeneficiaryData() async {
    try {
      var uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
      final response = await http.get(uri);
      print("response.body = ${response.body}");
      final result = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        var responseData = todoModelFromJson(result);
        todoModelList = responseData;
        print("responseData================ ${responseData[0].title}");
        setState(() {
          isCheck = true;
        });

        return responseData;
        print("successful");
      } else {
        print("Failed");
        return [];
      }
    } catch (e) {
      print("error = $e");
    }

    return [];
  }

  @override
  void initState() {
    super.initState();
    BeneficiaryData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.black,
            child: Text('বেনেফিসারির তালিকা'),
          ),
        ),
        body: isCheck == true
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Container(
                        height: 30,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  right:
                                      BorderSide(width: 2, color: Colors.black),
                                )),
                                child: Text(
                                  "আইডি",
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  right:
                                      BorderSide(width: 2, color: Colors.black),
                                )),
                                child: Text(
                                  "ইউজার আইডি",
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  "টাইটেল",
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                  left:
                                      BorderSide(width: 2, color: Colors.black),
                                )),
                                child: Center(
                                  child: Text(
                                    "স্ট্যাটাস ",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: ListView.builder(
                          itemCount: todoModelList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  border: Border(
                                left:
                                    BorderSide(width: 2.0, color: Colors.black),
                                right:
                                    BorderSide(width: 2, color: Colors.black),
                                bottom:
                                    BorderSide(width: 2, color: Colors.black),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.black),
                                      )),
                                      child: Text(
                                        todoModelList[index].id.toString(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.black),
                                      )),
                                      child: Text(
                                        todoModelList[index].userId.toString(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          todoModelList[index].title.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            width: 2, color: Colors.black),
                                      )),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            todoModelList[index]
                                                .completed
                                                .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ]),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
