import 'package:flutter/material.dart';


Widget borderedTextBox({required String text, Function(String)? onChanged,required bool passwordSecure}) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(children: [
        TextFormField(
            decoration: InputDecoration(
              labelText: text,
              border: OutlineInputBorder(),
            ),
            obscureText: passwordSecure,
            onChanged: onChanged)
      ]));
}


const Color themeColorDeep = Colors.orangeAccent;

Text GrayText(String txt) {
  return Text(
    txt,
    style: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black45,
    ),
  );
}

Widget orangeRoundButton(
    {required String text, required Function()? onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Container(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.white10,
          backgroundColor: Colors.orange,
          shape: const StadiumBorder(),
          side: const BorderSide(color: Colors.white, width: 0),
        ),
        onPressed: onPressed,
      ),
    ),
  );
}

Widget smallOrangeRoundButton(
    {required String text, required Function()? onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Container(
      height: 30,
      child: OutlinedButton(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.white10,
          backgroundColor: Colors.orange,
          shape: const StadiumBorder(),
          side: const BorderSide(color: Colors.white, width: 0),
        ),
        onPressed: onPressed,
      ),
    ),
  );
}

Widget whiteBorderRoundButton(
    {required String text, required Function()? onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Container(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.orange,
          ),
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.white10,
          backgroundColor: Colors.white,
          shape: const StadiumBorder(),
          side: const BorderSide(color: Colors.orange, width: 1),
        ),
        onPressed: onPressed,
      ),
    ),
  );
}

AppBar whiteAppbar({required String text}) {
  return AppBar(
    backgroundColor: Colors.white10,
    elevation: 0.0,
    title: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 21,
        color: Colors.black87,
      ),
    ),
  );
}

Padding grayTextRight({required String text}){
  return Padding(
    padding: const EdgeInsets.only(top:4.0),
    child: Align(
        alignment: Alignment.topRight,
        child:Text(text,
          style:TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.black54,
          ),
        )
    ),
  );
}
Padding grayTextLeft({required String text}){
  return Padding(
    padding: const EdgeInsets.only(top:4.0),
    child: Align(
        alignment: Alignment.topLeft,
        child:Text(text,
          style:TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.black54,
          ),
        )
    ),
  );
}

Padding grayBiggerTextRight({required String text}){
  return Padding(
    padding: const EdgeInsets.only(top:8.0),
    child: Align(
        alignment: Alignment.topRight,
        child:Text(text,
          style:TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black54,
          ),
        )
    ),
  );
}


Padding blackBiggerTextLeft({required String text}){
  return Padding(
    padding: const EdgeInsets.only(top:8.0),
    child: Align(
        alignment: Alignment.topLeft,
        child:Text(text,
          style:TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black87,
          ),
        )
    ),
  );
}

Padding orangeBorderContainer({required String text}){
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Container(
      child:Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(text,
          style:TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.orange,
          ),
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepOrange),
        borderRadius: BorderRadius.circular(20),
      ),),
  );
}


IconButton graySmallIconButton({required IconData icon,required Function()? onPressed }){

  return
    IconButton(
      icon: Icon(icon),
      iconSize: 28,
      color: Colors.black54,
      onPressed: onPressed,
    );

}