import 'package:flutter/material.dart';

class CustomWidget {
  /*Color gradientStart = Colors.deepPurple[700]; //Change start gradient color here
  Color gradientEnd = Colors.purple[500];*/

  Color gradientStart = Color(0xFF734b6d); //Change start gradient color here
  Color gradientEnd = Color(0xFF42275a);
  Color gradientAppBar = Color(0xFF9A6095);

  /*Color gradientStart = Color(0xFF9A6095); //Change start gradient color here
  Color gradientEnd = Color(0xFF42275a);*/

  CustomWidget();

  Widget customTextFormField() {
    return TextFormField(
      //controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        //-- default
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(0.0)),
        //-- after focus on widget
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(0.0)),

        border: OutlineInputBorder(),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  //---- Make Parent Background
  BoxDecoration customParentBgDecoration() {
    return new BoxDecoration(
      gradient: LinearGradient(
        /*begin: Alignment.centerRight,
                               end: Alignment.centerLeft,*/
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [gradientStart, gradientEnd],
        //colors: [Colors.blue, Colors.red])),
      ),
      //image: new DecorationImage(image: new AssetImage("images/excercise.png"),fit: BoxFit.fill,),
    );
  }

  ///----- custom TextFormField Decoration
  InputDecoration customTextFormFieldBorder(String hintText) {
    return new InputDecoration(
      //-- default
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(0.0)),
      //-- after focus on widget
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(0.0)),

      border: OutlineInputBorder(),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(color: Colors.yellowAccent),
      counterText: "",
    );
  }

  ///----- custom TextFormField Decoration
  InputDecoration customTextFormFieldBorderTest(String hintText, String errorText) {
    return new InputDecoration(
      //-- default
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(0.0)),
      //-- after focus on widget
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(0.0)),

      border: OutlineInputBorder(),
      hintText: hintText,
      errorText: errorText,
      hintStyle: TextStyle(color: Colors.white),
      errorStyle: TextStyle(color: Colors.yellowAccent),
      counterText: "",
    );
  }

  double buttonHeight() {
    return 50.0;
  }

  //--- App Bar
  Widget myAppBarColor() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [gradientAppBar, gradientAppBar])),
    );
  }
}
