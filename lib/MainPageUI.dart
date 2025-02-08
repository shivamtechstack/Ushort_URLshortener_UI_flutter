import 'package:flutter/material.dart';

class MainPageUI extends StatelessWidget{
const MainPageUI({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        "Ushort",
        style: TextStyle(
          color: Colors.white,
          fontSize: 34,
        ),
      ),
      backgroundColor: Colors.blue,
    ),
    body: Padding(
      padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Ensures content is centered
        children: [
          Center( // Centers the container horizontally
            child: IntrinsicWidth(
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Shrinks width to fit content
                  children: [
                    textView("Enter the URL to shorten"),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        editTextField("Place your long URL here..", 350),
                        SizedBox(width: 16),
                        editTextField("Custom code (Optional)", 220),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          button(),
          SizedBox(height: 12),
          warningText("Warning"),
          SizedBox(height: 16),
          textView("Shortened URL"),
        ],
      ),
    ),
  );
}


Widget editTextField(String hint, double receivedWidth) {
  return Container(
    width: receivedWidth, // Width
    height: 50, // Height
    padding: EdgeInsets.symmetric(horizontal: 10), // Add padding
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue, width: 2), // Border
      borderRadius: BorderRadius.circular(8), // Rounded corners
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none, // Removes default border
      ),
    ),
  );
}

Widget button(){
    return ElevatedButton(
      onPressed: (){},
     style: ElevatedButton.styleFrom(
       backgroundColor: Colors.blueAccent,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(5),
       ),
     ), child: Text("Shorten URL", style: TextStyle(fontSize: 16,
    color: Colors.white),
    )
    );
}

Widget warningText(String warningLabel){
    return Container(
        child: Text(warningLabel,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16)
        )
    );
}

Widget textView(String label){
    return Container(// Height
      child: Text(label,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18)
      )
    );
}
}