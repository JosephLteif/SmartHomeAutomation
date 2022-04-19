import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fleasy/fleasy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/services/OpenHabService.dart';
import 'package:smarthomeautomation/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('isLoggedIn')??false){
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceState>(
      builder: (context, appearanceState, child) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Spacer(flex: 1,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Smart ",
                          style: TextStyle(
                              fontSize: 38.0,
                              fontWeight: FontWeight.bold,
                              color: appearanceState.isDarkMode
                                  ? darkColorTheme
                                  : lightColorTheme)),
                      const Text("Home",
                          style: TextStyle(
                              fontSize: 38.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(flex: 1,),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    keyboardAppearance: appearanceState.isDarkMode
                              ? Brightness.dark:Brightness.light,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        ),
                        label: const Text('Email'),
                      hintText: 'johnDoe@hotmail.com',
                    ),
                    validator: (email){
                      if(email.isEmail || email!.isEmpty){
                        return null;
                      }
                      return 'Invalid Email';
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    keyboardAppearance: appearanceState.isDarkMode
                              ? Brightness.dark:Brightness.light,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        ),
                        label: const Text('password'),
                      hintText: '********',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if(await OpenHabService().checkAuthentication(emailController.text, passwordController.text)) {
                          Fluttertoast.showToast(
                            msg: "Login Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: appearanceState.isDarkMode
                              ? darkColorTheme
                              : lightColorTheme,
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                          prefs.setString('email', emailController.text);
                          prefs.setString('password', passwordController.text);
                          prefs.setBool('isLoggedIn', true);
                          Navigator.pushReplacementNamed(context, '/main');
                        } else {
                          Fluttertoast.showToast(
                            msg: "Login Failed",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                        }
                      },
                      child: const Text("Login"),),
                    ],
                  ),
                  const Spacer(flex: 2,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}