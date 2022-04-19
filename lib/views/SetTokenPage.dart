import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:smarthomeautomation/utils/labels.dart';
import 'package:smarthomeautomation/widgets/TopRowBar.dart';

class SetTokenPage extends StatefulWidget {
  SetTokenPage({ Key? key }) : super(key: key);

  @override
  State<SetTokenPage> createState() => _SetTokenPageState();
}

class _SetTokenPageState extends State<SetTokenPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceState>(
      builder: (context, appearanceState, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TopRowBar(title: lbl_SetToken),
                  const Spacer(flex: 1,),
                  TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      keyboardAppearance: appearanceState.isDarkMode
                                ? Brightness.dark:Brightness.light,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          ),
                          label: const Text('Token'),
                        hintText: 'oh.TokenName.gJydedDZU0ertwwertVy2dfsgdfgfdsagKykasdfadfghsdafgaJerwtu2NhCYixasdgadfgA',
                      ),
                      validator: (email){
                        if(email!.isNotEmpty){
                          return 'Empty field';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Set'),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if(await prefs.setString('X-OPENHAB-TOKEN', _controller.text)){
                        Fluttertoast.showToast(
                            msg: "Token Saved Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: appearanceState.isDarkMode
                              ? darkColorTheme
                              : lightColorTheme,
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                      Navigator.pushReplacementNamed(context, '/main');
                      } else {
                        Fluttertoast.showToast(
                            msg: "Error Saving Token",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: appearanceState.isDarkMode
                              ? darkColorTheme
                              : lightColorTheme,
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                      }
                    },
                  ),
                  const Spacer(flex: 1,),
                ],        
              ),
            )),
        ),
      ),
    );
  }
}