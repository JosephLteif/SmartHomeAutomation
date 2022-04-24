import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fleasy/fleasy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthomeautomation/providers/AppearanceState.dart';
import 'package:smarthomeautomation/services/OpenHabService.dart';
import 'package:smarthomeautomation/utils/colors.dart';
import 'package:smarthomeautomation/utils/labels.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(prefs_IsLoggedIn) ?? false) {
      if (prefs
            .getString(prefs_X_OPENHAB_TOKEN)
            .toString() ==
        '' || prefs.getString(prefs_X_OPENHAB_TOKEN) == null) {
      Navigator.pushReplacementNamed(
          context, '/setToken');
      } else{
        Navigator.pushReplacementNamed(context, '/main');
      }
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
                  const Spacer(
                    flex: 1,
                  ),
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
                              fontSize: 38.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    keyboardAppearance: appearanceState.isDarkMode
                        ? Brightness.dark
                        : Brightness.light,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text(lbl_Email),
                      hintText: lbl_PlaceHolderEmail,
                    ),
                    validator: (email) {
                      if (email.isEmail || email!.isEmpty) {
                        return null;
                      }
                      return lbl_InvalidEmail;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    keyboardAppearance: appearanceState.isDarkMode
                        ? Brightness.dark
                        : Brightness.light,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text(lbl_Password),
                      hintText: lbl_PlaceHolderPassword,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (await OpenHabService().checkAuthentication(
                              emailController.text, passwordController.text)) {
                            Fluttertoast.showToast(
                                msg: lbl_LoginSuccess,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: appearanceState.isDarkMode
                                    ? darkColorTheme
                                    : lightColorTheme,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            prefs.setString(prefs_email, emailController.text);
                            prefs.setString(
                                prefs_password, passwordController.text);
                            prefs.setBool(prefs_IsLoggedIn, true);
                            prefs = await SharedPreferences.getInstance();
                            if (prefs
                                    .getString(prefs_X_OPENHAB_TOKEN)
                                    .toString() ==
                                '' || prefs.getString(prefs_X_OPENHAB_TOKEN) == null) {
                              Navigator.pushReplacementNamed(
                                  context, '/setToken');
                            } else {
                              Navigator.pushReplacementNamed(context, '/main');
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: lbl_LoginFailed,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            
                          }
                        },
                        child: const Text(lbl_Login),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
