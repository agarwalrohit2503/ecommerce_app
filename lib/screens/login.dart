import 'package:ecommerce_application/screens/home_screen.dart';
import 'package:ecommerce_application/widgets/form_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  FirebaseAuth _firebaseAuth;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();

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
        final UserCredential userCred = await _firebaseAuth
            .signInWithEmailAndPassword(email: _email, password: _pwd);

        User user = userCred.user;
        if (user == null) {
          Toast.show("No such user", context);
          final UserCredential newUserCred = await _firebaseAuth
              .createUserWithEmailAndPassword(email: _email, password: _pwd);
          User newUser = newUserCred.user;

          print(newUser.uid);
        } else {
          Toast.show("Success", context);
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        Toast.show("Some error happended", context);
      }

      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (context) => HomeScreen(),
      // ));
    } else {
      Toast.show("Please enter the details first!", context);
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
