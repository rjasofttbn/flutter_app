import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_project/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => UupdatePasswordState();
}

class UupdatePasswordState extends State<UpdatePassword> {
  TextEditingController NewPasswordText = TextEditingController();
  TextEditingController ConfirmPasswordText = TextEditingController();
  TextEditingController OTPText = TextEditingController();

  String new_pass = 'a';
  String confirm_pass = 'a';
  String otp = 'a';
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.black,
            child: Text('আপনার পাসওয়ার্ড আপডেট করুন '),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "পাসওয়ার্ড আপডেট করুন ",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 35),
                  Container(
                    color: Colors.grey.shade200,
                    child: TextFormField(
                      controller: NewPasswordText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'নতুন পাসওয়ার্ড লিখুন',
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'নতুন পাসওয়ার্ড লিখুন ';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.grey.shade200,
                    child: TextFormField(
                      controller: ConfirmPasswordText,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'কনফার্ম পাসওয়ার্ড লিখুন',
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'কনফার্ম পাসওয়ার্ড লিখুন';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.grey.shade200,
                    child: TextFormField(
                      controller: OTPText,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.mobile_friendly),
                        hintText: 'OTP লিখুন',
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'OTP লিখুন';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  //validation for null
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          if (otp == OTPText.text) {
                            print(NewPasswordText.text);
                            // print(passwordController.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Dashboard(),
                                ));
                          } else {
                            Fluttertoast.showToast(
                                msg: "দয়া করে বৈধ ওটিপি লিখুন!!!",
                                toastLength: Toast.LENGTH_LONG,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                gravity: ToastGravity.CENTER);
                          }
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'সাবমিট করুন',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
