import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_application/models/user.dart';
import 'package:ecommerce_application/screens/home_screen.dart';
import 'package:ecommerce_application/widgets/form_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:ecommerce_application/globals.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    firebaseAuth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    userCollection = firestore.collection("users");
  }

  _handlePasswordReset() async {
    String _email = _emailController.text.trim();

    await firebaseAuth.sendPasswordResetEmail(email: _email);
  }

  _handleLogout() async {
    await firebaseAuth.signOut();
  }

  _handleLogin() async {
    //using this email and password
    //
    String _email = _emailController.text.trim();
    String _pwd = _pwdController.text.trim();
    if (_email != '' && _pwd != '') {
      try {
        setState(() {
          _isLoading = true;
        });

        final UserCredential userCred = await firebaseAuth
            .signInWithEmailAndPassword(email: _email, password: _pwd);

        User user = userCred.user;
        if (user == null) {
          Toast.show("No such user", context);
        } else {
          Toast.show("Success", context);
          DocumentSnapshot userData =
              (await userCollection.doc(user.uid).get());
          currentUser = UserModal.fromJson(userData.data());

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        }
      } catch (e) {
        if (e.code == "user-not-found") {
          _register(_email, _pwd);
        } else {
          Toast.show("Please check your credentails", context);
        }
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      Toast.show("Please enter the details first!", context);
    }
  }

  _register(_email, _pwd) async {
    try {
      final UserCredential newUserCred = await firebaseAuth
          .createUserWithEmailAndPassword(email: _email, password: _pwd);
      User newUser = newUserCred.user;

      //save the data in the db
      //

      userCollection.doc(newUser.uid).set({
        'user_id': newUser.uid,
        'email_address': newUser.email,
      });
      DocumentSnapshot userData = (await userCollection.doc(newUser.uid).get());
      currentUser = UserModal.fromJson(userData.data());
      print(newUser.uid);
      Toast.show("Registered Successfully", context);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    } catch (e) {
      Toast.show("Email Already In Use", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              CustomTextField(
                title: "Email ID",
                controller: _emailController,
              ),
              CustomTextField(
                title: "Password",
                isNotVisible: true,
                controller: _pwdController,
              ),
              TextButton(
                onPressed: _handleLogin,
                child: Text("Login / Register"),
              ),
              TextButton(
                onPressed: _handlePasswordReset,
                child: Text("Forgot Password"),
              )
            ],
          ),
          (_isLoading)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
