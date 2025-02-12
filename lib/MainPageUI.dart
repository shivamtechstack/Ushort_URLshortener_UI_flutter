import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ushort/services/url_shortener_service.dart';
import 'package:http/http.dart' as http;

class MainPageUI extends StatefulWidget {
  const MainPageUI({super.key});

  @override
  _MainPageUIState createState() => _MainPageUIState();
}

class _MainPageUIState extends State<MainPageUI>{

  @override
  void initState() {
    super.initState();
    testRender();  // Call testRender on app start
    // testPost();  // Uncomment this if you want to test POST
  }

  void testRender() async {
    try {
      final response = await http.get(Uri.parse("https://localhost:8080/"));
      print("Render Response Status: ${response.statusCode}");
      print("Render Response Body: ${response.body}");
    } catch (e) {
      print("Error: $e");
    }
  }

  void testPost() async {
    try {
      final response = await http.post(Uri.parse("https://localhost:8080/shorten"));
      print("Post Response Status: ${response.statusCode}");
      print("Post Response Body: ${response.body}");
    } catch (e) {
      print("Error: $e");
    }
  }

  final TextEditingController _originalUrlController = TextEditingController();
  final TextEditingController _customCodeController = TextEditingController();
  String _shortenedURL = "";
  String _errorMessage = "";

  final UrlShortenerService _urlShortenerService = UrlShortenerService();

  Future<void> shortenUrl() async{
    String originalUrl = _originalUrlController.text;
    String customCode = _customCodeController.text;

    String? result = await _urlShortenerService.shortenUrl(originalUrl, customShortCode: customCode);

    setState(() {
      if (result != null && result.startsWith("http")) {
        _shortenedURL = result;
        _errorMessage = "";
      } else {
        _errorMessage = result ?? "Unknown error occurred.";
        _shortenedURL = "";
      }
    });
  }

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
      body: SingleChildScrollView( // Prevent overflow
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 70, 20, 20), // Add bottom padding
          child: Column(
            mainAxisSize: MainAxisSize.min, // Avoid infinite height issue
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textView("Enter the URL to shorten"),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            editTextField("Place your long URL here..", _originalUrlController, 350),
                            SizedBox(width: 16),
                            editTextField("Custom code (Optional)", _customCodeController, 220),
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
              warningText(_errorMessage),
              SizedBox(height: 16),

              Center( // Ensures URL is in the center
                child: textView(_shortenedURL, showIcon: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Updated textView for copying functionality
  Widget textView(String label, {bool showIcon = false}) {
    return Align( // Align text to center
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center row contents
        children: [
          SelectableText(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          if (showIcon && label.isNotEmpty) ...[
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: label));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Copied to clipboard')),
                );
              },
              child: Icon(Icons.copy, color: Colors.blue),
            ),
          ],
        ],
      ),
    );
  }


Widget editTextField(String hint, TextEditingController controller,double receivedWidth) {
  return Container(
    width: receivedWidth, // Width
    height: 50, // Height
    padding: EdgeInsets.symmetric(horizontal: 10), // Add padding
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue, width: 2), // Border
      borderRadius: BorderRadius.circular(8), // Rounded corners
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none, // Removes default border
      ),
    ),
  );
}

Widget button(){
    return Container(
      height: 50,
      child: ElevatedButton(
      onPressed: shortenUrl,
     style: ElevatedButton.styleFrom(
       backgroundColor: Colors.blueAccent,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(5),
       ),
     ), child: Text("Shorten URL", style: TextStyle(fontSize: 16,
    color: Colors.white),
    )));
}

Widget warningText(String warningLabel){
    return Container(
        child: Text(warningLabel,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16)
        ));
}
}