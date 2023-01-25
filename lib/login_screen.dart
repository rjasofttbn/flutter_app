import 'package:flutter/material.dart';
import 'package:flutter_project/dashboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_project/forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureTex = true;

  String user_email = 'a';
  String user_password = 'a';
  final formKey = GlobalKey<FormState>();
  String title = "Login";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "খাদ্য বান্ধব কর্মসূচী",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      SizedBox(height: 10),
                      Image.asset(
                        "flutter_assets/dgfood.png",
                        height: 70,
                        width: 70,
                      ),
                      SizedBox(height: 30),
                      Text(
                        "সাইন ইন করুন",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 35),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade200,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ইউজার আইডি লিখুন',
                              hintText: 'ইউজার আইডি লিখুন',
                              //men icon set
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ইউজার আইডি লিখুন';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: 15),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.shade200,
                        //TextFormField use for validation data catch
                        child: TextFormField(
                          // textAlign: TextAlign.start,
                          controller: passwordController,
                          obscureText: obscureTex,
                          obscuringCharacter: "#",
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 18),
                            prefixIcon:
                                const Icon(Icons.lock, color: Colors.black),
                            border: const OutlineInputBorder(),
                            labelText: 'ইউজার পাসওয়ার্ড লিখুন',
                            hintText: 'ইউজার পাসওয়ার্ড',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureTex = !obscureTex;
                                });
                              },
                              // icon validation true false
                              icon: Icon(obscureTex == true
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'ইউজার পাসওয়ার্ড লিখুন';

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      //validation for null
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              if (user_email == emailController.text &&
                                  user_password == passwordController.text) {
                                print(emailController.text);
                                print(passwordController.text);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(),
                                    ));
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "Please insert valid user name and password!!!",
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
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "লগইন করুন",
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          'পাসওয়ার্ড ভুলে গেছেন ?',
                        ),
                      ),
                      // SizedBox(height: 10),
                      // Container(
                      //   child: Text('Forget Password'),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
