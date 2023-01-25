import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class OTPInsert extends StatefulWidget {
  const OTPInsert({super.key});

  @override
  State<OTPInsert> createState() => _OTPInsertState();
}

class _OTPInsertState extends State<OTPInsert> with TickerProviderStateMixin {
  void showToast() {
    Fluttertoast.showToast(
        msg: 'This is toast notification',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.yellow);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OverlayState? overlayState = Overlay.of(context);
  }

  void topMessage(OverlayState context) {
    showTopSnackBar(
      context,
      CustomSnackBar.success(
        message: "Good job, your release is successful. Have a nice day",
      ),
    );
  }

  TextEditingController OTPText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('মোবাইল থেকে OTP নাম্বার লিখুন'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade100,
              //TextFormField use for validation data catch
              child: TextFormField(
                controller: OTPText,
                obscuringCharacter: "#",
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  prefixIcon: const Icon(Icons.numbers, color: Colors.black),
                  border: const OutlineInputBorder(),
                  labelText: 'আপনার OTP নাম্বার লিখুন',
                  hintText: 'আপনার OTP নাম্বার লিখুন',
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                // showTopSnackBar(
                //   overlayState,
                //   CustomSnackBar.success(
                //     message:
                //         "Good job, your release is successful. Have a nice day",
                //   ),
                // );
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "সাবমিট",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
