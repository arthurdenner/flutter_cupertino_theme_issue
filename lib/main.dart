import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_mode_handler/theme_mode_handler.dart';
import 'package:theme_mode_handler/theme_picker_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeModeHandler(
      builder: (themeMode) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: themeMode,
          darkTheme: ThemeData(brightness: Brightness.dark),
          theme: ThemeData(brightness: Brightness.light),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _chooseThemeMode() async {
    await showThemePickerDialog(context: context);
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text("This alert respects theme.Brightness"),
        actions: <Widget>[
          FlatButton(
            child: Text('Close'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  void _showCupertinoDialog() {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        content: Text(
          "This alert doesn't respect theme.Brightness but the device's brightness",
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Close',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected themeMode:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              ThemeModeHandler.of(context).themeMode.toString(),
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: _showCupertinoDialog,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Display CupertinoAlertDialog',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: _showAlertDialog,
              color: Theme.of(context).primaryColor,
              child: Text(
                'Display AlertDialog',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _chooseThemeMode,
        tooltip: 'Choose themeMode',
        child: Icon(Icons.settings),
      ),
    );
  }
}
