import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/Screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loadin_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String token = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController uniqueIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> formValidation() async {
    if (passwordController.text == confirmPasswordController.text) {
      if (emailController.text.isNotEmpty &&
          uniqueIdController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty) {
        showDialog(
            context: context,
            builder: (c) {
              return LoadingDialog(
                message: "Registering Account",
              );
            });

        authenticateAndSignUp();
      } else {
        showDialog(
            context: context,
            builder: (c) => ErrorDialog(
                  message:
                      "Please write the required info for the Registration",
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (c) => ErrorDialog(
                message: "Password do not match",
              ));
    }
  }

  void authenticateAndSignUp() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) => ErrorDialog(
                message: error.message.toString(),
              ));
    });
    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        //send user to home page
        Route newRoute = MaterialPageRoute(builder: (c) => DashboardPage());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    token = (await FirebaseMessaging.instance.getToken())!;
    print(token);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .set({
      "uid": currentUser.uid,
      "uniqueId": uniqueIdController.text.trim(),
      "email": currentUser.email,
      "name": nameController.text.trim(),
      "fcmToken": token,

      // "lat": position!.latitude,
      // "lng": position!.longitude,
    });
    //save data locally
    sharedPreferences = await SharedPreferences.getInstance(); //instance
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!
        .setString("uniqueId", uniqueIdController.text.trim());
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 20,
          ),
          // Text(
          //   "Create Account",
          //   style: TextStyle(
          //       color: Colors.white70,
          //       fontSize: 30,
          //       fontWeight: FontWeight.bold),
          // ),
          const SizedBox(
            height: 15,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: nameController,
                  data: Icons.person,
                  hintText: "Name",
                  isObscure: false,
                ),
                CustomTextField(
                  controller: uniqueIdController,
                  data: Icons.border_left_rounded,
                  hintText: "Unique Id",
                  isObscure: false,
                ),
                CustomTextField(
                  controller: emailController,
                  data: Icons.email,
                  hintText: "Email",
                  isObscure: false,
                ),
                CustomTextField(
                  controller: passwordController,
                  data: Icons.lock,
                  hintText: "Password",
                  isObscure: true,
                ),
                CustomTextField(
                  controller: confirmPasswordController,
                  data: Icons.person,
                  hintText: "ConfirmPassword",
                  isObscure: true,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => formValidation(),
            child: const Text(
              "Register",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 50)),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
