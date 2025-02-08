import 'package:flutter/material.dart';

class MainPageUI extends StatelessWidget{
const MainPageUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ushort",
        style: TextStyle(color: Colors.white,
        fontSize: 34,
        ),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(padding: const EdgeInsets.all(20.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                editTextField("Enter Url"),
                SizedBox(width: 16),
                editTextField("Custom Short Code"),
              ],
            ),
              SizedBox(height: 16),
              button()
            ],
      ),
      ),
    );
  }

Widget editTextField(String hint) {
  return Container(
    width: 300, // Width
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
     ), child: Text("Shorten Url", style: TextStyle(fontSize: 16,
    color: Colors.white),
    ),
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