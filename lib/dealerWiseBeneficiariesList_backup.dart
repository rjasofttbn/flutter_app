import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter_project/models/dealear_wise_ben_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/otp_insert.dart';

class DealerWiseBeneficiaries extends StatefulWidget {
  const DealerWiseBeneficiaries({super.key});

  @override
  State<DealerWiseBeneficiaries> createState() =>
      _DealerWiseBeneficiariesState();
}

class _DealerWiseBeneficiariesState extends State<DealerWiseBeneficiaries> {
  var isData = false;

  final TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  DealearWiseBenListModel dealearWiseBenListModel = DealearWiseBenListModel();
  List<DealearWiseBenListModel> dealearWiseBenListModelList =
      <DealearWiseBenListModel>[];

  var decodedImage;
  Future<DealearWiseBenListModel?> findUserInfo(String id) async {
    Map<String, dynamic> bodyData = {"token": "FFP@DGFOOD#BCL&0088", "id": 2};
    var body = jsonEncode(bodyData);
    try {
      var uri = Uri.parse('https://202.84.36.139/FFPAPI/api/mobile/dealerId');
      final response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
      print("response.body = ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          var resData = dealearWiseBenListModelFromJson(
              jsonDecode(utf8.decode(response.bodyBytes))["ben"]);
          dealearWiseBenListModelList = resData;
          print("====================== ${dealearWiseBenListModel.id}");
          Uint8List decodedbytes =
              base64.decode(dealearWiseBenListModel.image.toString());
          print("-----------============ $decodedbytes");

          isData = true;
        });
      } else {
        setState(() {
          isData = false;
        });
      }
    } catch (e) {
      print("error = $e");
      setState(() {
        isData = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("gdghdgfhf==============");
    findUserInfo("2");
  }

  var id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.black,
            child: Text('বেনেফিসারি সার্চ'),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: dealearWiseBenListModelList.length,
              itemBuilder: (context, index) {
                return Visibility(
                  visible: isData,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blue[100],
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.memory(
                          width: 130.0,
                          height: 155.0,
                          fit: BoxFit.fill,
                          base64Decode(
                              '${dealearWiseBenListModelList[index].image}'),
                        ),
                        SizedBox(width: 15),
                        Container(
                          //color: Colors.red,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "নাম : ${dealearWiseBenListModelList[index].ecBeneficiaryName ?? "Name is Empty"}"),
                              Text(
                                  "মোবাইল নাম্বার : ${dealearWiseBenListModelList[index].givenMobileNo ?? "MobileNo is Empty"}"),
                              Text(
                                  "কার্ড নাম্বার: ${dealearWiseBenListModelList[index].cardNo ?? "cardNo is Empty"}"),
                              Text(
                                  "ইউনিয়ন : ${dealearWiseBenListModelList[index].unionName ?? "unionName is Empty"}"),
                              Text(
                                  "ডিলার : ${dealearWiseBenListModelList[index].dealerName ?? "DealerName is Empty"}"),
                              TextButton(
                                child: const Text('Send OTP'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OTPInsert(),
                                      ));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),

      // : Center(
      //           child: CircularProgressIndicator(),
      //         ),
    );
  }
}
