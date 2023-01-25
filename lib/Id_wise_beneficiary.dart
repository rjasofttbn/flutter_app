import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter_project/models/Id_wise_beneficiary_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_projct/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_project/otp_insert.dart';
// import 'package:intl/intl.dart';

class IdWiseData extends StatefulWidget {
  const IdWiseData({super.key});

  @override
  State<IdWiseData> createState() => _IdWiseDataState();
}

class _IdWiseDataState extends State<IdWiseData> {
  var isData = false;
  final TextEditingController searchController = TextEditingController();

  IdWiseBeneficiaryModel idWiseBeneficiaryModel = IdWiseBeneficiaryModel();
  var decodedImage;
  Future<IdWiseBeneficiaryModel?> findUserInfo(String id) async {
    Map<String, dynamic> bodyData = {"token": "FFP@DGFOOD#BCL&0088", "id": id};
    var body = jsonEncode(bodyData);
    try {
      var uri = Uri.parse('https://202.84.36.139/FFPAPI/api/mobile/benId');
      final response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
      print("response.body = ${response.body}");

      if (response.statusCode == 200) {
        setState(() {
          idWiseBeneficiaryModel = IdWiseBeneficiaryModel.fromJson(
              jsonDecode(utf8.decode(response.bodyBytes))["ben"][0]);

          print("====================== ${idWiseBeneficiaryModel.id}");
          Uint8List decodedbytes =
              base64.decode(idWiseBeneficiaryModel.image.toString());
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade100,
                //TextFormField use for validation data catch
                child: TextFormField(
                  controller: searchController,
                  obscuringCharacter: "#",
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    border: const OutlineInputBorder(),
                    labelText: 'আপনার কার্ড নাম্বার লিখুন',
                    hintText: 'আপনার কার্ড নাম্বার লিখুন',
                  ),
                  validator: (value) {
                    if (value == '') {
                      return 'দয়া করে আপনার কার্ড নাম্বার লিখুন';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  await findUserInfo(searchController.text);

                  // if (searchController.text == '') {
                  //   Fluttertoast.showToast(
                  //       msg: "দয়া করে আপনার কার্ড নাম্বার লিখুন!!!",
                  //       toastLength: Toast.LENGTH_LONG,
                  //       timeInSecForIosWeb: 1,
                  //       backgroundColor: Colors.red,
                  //       gravity: ToastGravity.CENTER);
                  //   // print(NewPasswordText.text);
                  // }
                  setState(() {
                    id = idWiseBeneficiaryModel.id.toString();
                    var testData = idWiseBeneficiaryModel.ecBeneficiaryName
                        .toString()
                        .codeUnits;
                    // var encoded = utf8.encode("$testData");
                    // var decoded = utf8.decode(encoded);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "সার্চ করুন ",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Text("${idWiseBeneficiaryModel.id}"),
              Visibility(
                visible: isData,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blue[100],
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    // children: [
                    children: [
                      Container(
                        color: Colors.black,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              child: Image.memory(
                                height: 145,
                                width: 140,
                                fit: BoxFit.fill,
                                base64Decode('${idWiseBeneficiaryModel.image}'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "নাম : ${idWiseBeneficiaryModel.ecBeneficiaryName ?? "Id is Empty"}"),
                          Text(
                              "মোবাইল নাম্বার : ${idWiseBeneficiaryModel.givenMobileNo ?? "Id is Empty"}"),
                          Text(
                              "কার্ড নাম্বার: ${idWiseBeneficiaryModel.cardNo ?? "Id is Empty"}"),
                          Text(
                              "ইউনিয়ন : ${idWiseBeneficiaryModel.unionName ?? "Id is Empty"}"),
                          Text(
                              "ডিলার : ${idWiseBeneficiaryModel.dealerName ?? "Id is Empty"}"),
                          // Text( "জন্ম তারিখ : ${idWiseBeneficiaryModel.dateOfBirth ?? "Id is Empty"}"),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
