import 'package:ecommerce_application/constants/appColors.dart';
import 'package:ecommerce_application/data/sendApis.dart';
import 'package:ecommerce_application/globals.dart';
import 'package:ecommerce_application/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class UserForm extends StatefulWidget {
  UserForm({Key key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  bool _isLoading = false;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();

  _handleSave() async {
    //call api and save data
    //
    String _name = _nameController.text.trim();
    String _age = _ageController.text.trim();
    if (_name != "" && _age != "") {
      setState(() {
        _isLoading = true;
      });

      //api call
      //
      bool response = await sendUserData(
          userAge: int.parse(_age),
          userId: currentUser.userId,
          userName: _name);
      if (response)
        Toast.show("Data Saved Successfully", context, gravity: 2);
      else
        Toast.show("Data Not Saved", context, gravity: 2);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor().mainColor,
        title: Text("User Form"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              CustomTextField(
                title: "Name",
                controller: _nameController,
              ),
              CustomTextField(
                title: "Age",
                controller: _ageController,
              ),
              TextButton(
                onPressed: _handleSave,
                child: Text("Save Data"),
              ),
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
