import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_project/login_screen.dart';
import 'package:flutter_project/models/todo_model.dart';
import 'package:flutter_project/profile.dart';
import 'package:flutter_project/beneficiariesList.dart';
import 'package:flutter_project/Id_wise_beneficiary.dart';
import 'package:flutter_project/dealerWiseBeneficiariesList.dart';
import 'package:flutter_project/beneficiary_detail.dart';
import 'package:http/http.dart' as http;

import 'models/Id_wise_beneficiary_model.dart';
import 'otp_insert.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  IdWiseBeneficiaryModel idWiseBeneficiaryModel = IdWiseBeneficiaryModel();
  // String _scanBarcode = 'Unknown';
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      var fixed = 'https://ffp.dgfood.gov.bd/';
      // var barcodeScanRes = 'https://ffp.dgfood.gov.bd/foodfriendly/qrview/100';
      var getBaseUrl = barcodeScanRes.substring(0, 26);
      print(getBaseUrl);
      var end = "foodfriendly/qrview/";
      var userId = barcodeScanRes.indexOf(end);
      var result = barcodeScanRes.substring(userId + end.length);
      print(result);
      if (fixed == getBaseUrl) {
        await findUserInfo(result);
      } else {
        print('url error');
      }

      // print("barcodeScanRes ======================== $barcodeScanRes");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    //   print("barcodeScanRes ============6464============ $barcodeScanRes");
    // });
  }

  Future<IdWiseBeneficiaryModel?> findUserInfo(String result) async {
    Map<String, dynamic> bodyData = {
      "token": "FFP@DGFOOD#BCL&0088",
      "id": result
    };
    var body = jsonEncode(bodyData);
    print('ee');
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

          // isData = true;
        });
      } else {
        setState(() {
          // isData = false;
        });
      }
    } catch (e) {
      print("error = $e");
      setState(() {
        // isData = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("gdghdgfhf==============parameter pass");
    findUserInfo('result');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                globalKey.currentState?.openDrawer();
              });
            },
            icon: Icon(Icons.menu),
          ),
          elevation: 0,
          title: Text("Header title bar"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                color: Colors.blue,
                height: 201,
                padding: EdgeInsets.only(
                  left: 20,
                  top: 20,
                  right: 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          // onTap: () {
                          //   var fixed = 'https://ffp.dgfood.gov.bd/';
                          //   var fixed_url =
                          //       'https://ffp.dgfood.gov.bd/foodfriendly/qrview/22';
                          //   var getBaseUrl = fixed_url.substring(0, 26);
                          //   // print(getBaseUrl);
                          //   var end = "foodfriendly/qrview/";
                          //   var userId = fixed_url.indexOf(end);
                          //   var result =
                          //       fixed_url.substring(userId + end.length);

                          //   if (fixed == getBaseUrl) {
                          //     Future<IdWiseBeneficiaryModel?> findUserInfo(
                          //         String result) async {
                          //       Map<String, dynamic> bodyData = {
                          //         "token": "FFP@DGFOOD#BCL&0088",
                          //         "id": result
                          //       };
                          //       var body = jsonEncode(bodyData);
                          //       print('ee');
                          //       try {
                          //         var uri = Uri.parse(
                          //             'https://202.84.36.139/FFPAPI/api/mobile/benId');
                          //         final response = await http.post(uri,
                          //             headers: {
                          //               "Content-Type": "application/json",
                          //             },
                          //             body: body);
                          //         print("response.body = ${response.body}");

                          //         if (response.statusCode == 200) {
                          //           setState(() {
                          //             idWiseBeneficiaryModel =
                          //                 IdWiseBeneficiaryModel.fromJson(
                          //                     jsonDecode(utf8.decode(response
                          //                         .bodyBytes))["ben"][0]);

                          //             print(
                          //                 "====================== ${idWiseBeneficiaryModel.id}");
                          //             Uint8List decodedbytes = base64.decode(
                          //                 idWiseBeneficiaryModel.image
                          //                     .toString());
                          //             print(
                          //                 "-----------============ $decodedbytes");

                          //             // isData = true;
                          //           });
                          //         } else {
                          //           setState(() {
                          //             // isData = false;
                          //           });
                          //         }
                          //       } catch (e) {
                          //         print("error = $e");
                          //         setState(() {
                          //           // isData = false;
                          //         });
                          //       }
                          //     }
                          //   } else {
                          //     print('url error');
                          //   }

                          //   @override
                          //   void initState() {
                          //     // TODO: implement initState
                          //     super.initState();
                          //     print("gdghdgfhf==============");
                          //     findUserInfo('result');
                          //   }
                          //   // print(result);
                          // },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage("flutter_assets/omar.jpg"),
                          ),
                        ),
                        Icon(Icons.sunny)
                      ],
                    ),
                    SizedBox(height: 35),
                    Text("Md. Omar Faruk"),
                    SizedBox(height: 5),
                    Text("01723158473"),
                  ],
                ),
              ),
              SizedBox(height: 1),
              Container(
                color: Colors.grey.shade300,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.person,
                  ),
                  title: Text("প্রোফাইল"),
                ),
              ),
              SizedBox(height: 1),
              Container(
                color: Colors.grey.shade300,
                child: ListTile(
                  onTap: () async {
                    Navigator.pop(context);
                    await scanQR();
                  },
                  leading: Icon(
                    Icons.qr_code,
                  ),
                  title: Text("QR কোড"),
                ),
              ),
              SizedBox(height: 1),
              Container(
                color: Colors.grey.shade300,
                child: ListTile(
                  onTap: () async {
                    // print("start");
                    // // await BeneficiaryData();
                    // print("end");
                    print(DealerWiseBeneficiaries());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DealerWiseBeneficiaries(),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.person_search,
                  ),
                  title: Text("বেনেফিসারির তালিকা"),
                ),
              ),
              SizedBox(height: 1),
              Container(
                color: Colors.grey.shade300,
                child: ListTile(
                  onTap: () async {
                    print("start");
                    // await BeneficiaryData();
                    // print("end");
                    // print(BeneficiaryData());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IdWiseData(),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.person_search,
                  ),
                  title: Text("কার্ড নাম্বার দিয়ে বেনেফিসারি সার্চ"),
                ),
              ),
              // SizedBox(height: 1),
              // Container(
              //   color: Colors.grey.shade300,
              //   child: ListTile(
              //     onTap: () async {
              //       print("start");
              //       // await BeneficiaryData();
              //       print("end");
              //       print(BeneficiaryData());
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => BeneficiaryList(),
              //         ),
              //       );
              //     },
              //     leading: Icon(
              //       Icons.person_search,
              //     ),
              //     title: Text("Example Api"),
              //   ),
              // ),
              SizedBox(height: 1),
              Container(
                color: Colors.grey.shade300,
                child: ListTile(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false);
                  },
                  leading: Icon(
                    Icons.exit_to_app,
                  ),
                  title: Text("এক্সিট"),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                // visible: isData,
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
                        height: 162.0,
                        fit: BoxFit.fill,
                        base64Decode('${idWiseBeneficiaryModel.image}'),
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
                                "নাম : ${idWiseBeneficiaryModel.ecBeneficiaryName ?? "Name is Empty"}"),
                            Text(
                                "মোবাইল নাম্বার : ${idWiseBeneficiaryModel.givenMobileNo ?? "MobileNo is Empty"}"),
                            Text(
                                "কার্ড নাম্বার: ${idWiseBeneficiaryModel.cardNo ?? "cardNo is Empty"}"),
                            Text(
                                "ইউনিয়ন : ${idWiseBeneficiaryModel.unionName ?? "unionName is Empty"}"),
                            // Text(
                            //     "ডিলার : ${idWiseBeneficiaryModel.dealerName ?? "DealerName is Empty"}"),
                            Row(
                              // textDirection: TextStyle(color: Colors.yellow),
                              children: <Widget>[
                                TextButton(
                                  child: Text('ওটিপি'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OTPInsert(),
                                      ),
                                    );
                                  },
                                ),
                                TextButton(
                                  child: Text('বিস্তারিত'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BeneficiaryDetail(
                                                  idWiseBeneficiaryModel:
                                                      idWiseBeneficiaryModel),
                                        ));
                                  },
                                ),
                                TextButton(
                                  child: Text('কল করুন'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OTPInsert(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
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
