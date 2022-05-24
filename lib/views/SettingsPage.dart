import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthomeautomation/providers/OpenHabState.dart';

import '../providers/AppearanceState.dart';
import '../services/FingerPrint.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool selectedValue = false;

  init() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool('authPrint');
    setState(() {
      selectedValue = repeat == true ? true : false;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppearanceState>(
      builder: (context, appearanceState, child) => SafeArea(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('Settings'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  onToggle: (value) async {
                    final prefs = await SharedPreferences.getInstance();

                    bool auth = await LocalAuthApi.authenticateIsAvailable();

                    if (auth) {
                      await prefs.setBool('authPrint', !(selectedValue));
                      prefs.commit();
                    }

                    setState(() {
                      selectedValue = !(selectedValue);
                    });
                  },
                  initialValue: selectedValue,
                  leading: const Icon(Icons.fingerprint),
                  title: const Text('Enable fingerPrint'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) async {
                    appearanceState.toggleDarkMode();
                  },
                  initialValue: appearanceState.isDarkMode,
                  leading: appearanceState.isDarkMode
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                  title: const Text('Set Theme'),
                ),
                SettingsTile.navigation(
                  trailing: SizedBox(
                    height: 40,
                    child: DropdownButton(
                              value: Provider.of<OpenHabState>(context).RefreshRate,
                              onChanged: (int? newValue) {
                                Provider.of<OpenHabState>(context, listen: false).setRefreshRate(newValue);
                              },
                              items: <int>[
                                5,
                                10,
                                15
                              ].map((int value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            ),
                  ),
                  leading: const Icon(Icons.monitor),
                  title: const Text('Set Refresh Rate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
