import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectone/StorageManager.dart';
import 'package:projectone/ThemeNotifier.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool themeMode = false;

  @override
  void initState() {
    getit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        theme: theme.getTheme(),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Hybrid Theme'),
          ),
          body: Center(
            child: CupertinoSwitch(
              value: themeMode,
              onChanged: (bool val) {
                print(val.toString());
                if (val == false) {
                  setState(() {
                    themeMode = val;
                    theme.setLightMode();
                  });
                } else {
                  setState(() {
                    themeMode = val;
                    theme.setDarkMode();
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void getit() async {
    Future<String> val = await StorageManager.readData("themeMode") ?? 'light';
    if (val == "light") {
      themeMode = false;
    } else {
      themeMode = true;
    }
  }
}
