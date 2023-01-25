import 'package:flutter/material.dart';
import 'package:flutter_project/update_password.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController TextMobileContrller = TextEditingController();
  String value = "";
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.black,
            child: Text('OTP জন্য মোবাইল নম্বর লিখুন '),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  "মোবাইল নম্বর ইনপুট করুন ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 35),
                Container(
                  color: Colors.grey.shade200,
                  child: TextFormField(
                    controller: TextMobileContrller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      prefixIcon: Icon(Icons.mobile_screen_share),
                      hintText: 'মোবাইল নম্বর লিখুন',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            value = TextMobileContrller.text;
                          });
                        },
                        icon: Icon(Icons.arrow_forward),
                      ),
                    ),
                    validator: (value) {
                      if (value == '') {
                        return 'দয়া করে আপনার মোবাইল নাম্বার লিখুন';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: value == "1"
                      ? () {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UpdatePassword(),
                              ),
                            );
                          } else {
                            print('Please enter your mobile no.');
                          }
                        }
                      : null,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    color: value != "1" ? Colors.grey.shade300 : Colors.blue,
                    child: Text(
                      'সাবমিট করুন',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
