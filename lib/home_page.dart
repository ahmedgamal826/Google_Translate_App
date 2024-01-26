import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

final _formkey = GlobalKey<FormState>();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var languages = [
    'English',
    'Arabic',
    'German',
    'French',
    'Hindi',
    'Italian',
    'Spanish',
    'Russian'
  ];
  var originalLanguage = "From";
  var destinationLanguage = "To";
  var output = " ";
  TextEditingController languageController = TextEditingController();

  void translate(String src, String des, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: des);

    setState(() {
      output = translation.text.toString();
    });

    if (src == ' ' || des == ' ') {
      setState(() {
        output = "Fail to translate";
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Hindi') {
      return 'hi';
    } else if (language == 'Arabic') {
      return 'ar';
    } else if (language == 'German') {
      return 'de';
    } else if (language == 'French') {
      return 'fr';
    } else if (language == 'Italian') {
      return 'it';
    } else if (language == 'Spanish') {
      return 'es';
    } else if (language == 'Russian') {
      return 'ru';
    }

    return '--';
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = false;
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        title: Text(
          'Google Translate',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originalLanguage,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(
                          dropDownStringItem,
                          style: TextStyle(fontSize: 25),
                        ),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originalLanguage = value!;
                      });
                    }),
                SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.arrow_right_alt_outlined,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 40,
                ),
                DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(
                          dropDownStringItem,
                          style: TextStyle(fontSize: 25),
                        ),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    }),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  maxLines: 5,
                  cursorColor: Colors.white,
                  textDirection:
                      // ignore: dead_code
                      isArabic ? TextDirection.rtl : TextDirection.ltr,
                  onChanged: (text) {
                    isArabic = text.contains(RegExp(r'[\u0600-\u06FF]+'));
                  },
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Enter yout text...',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.white)),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 20)),
                  controller: languageController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter text to translate'
                      : null,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xff2b3c5a)),
                onPressed: () {
                  _formkey.currentState!.validate();
                  translate(
                    getLanguageCode(originalLanguage),
                    getLanguageCode(destinationLanguage),
                    languageController.text.toString(),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 120,
                  child: Text(
                    'Translate',
                    style: TextStyle(fontSize: 28),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Center(
                child: SelectableText(
                  '\n$output',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
