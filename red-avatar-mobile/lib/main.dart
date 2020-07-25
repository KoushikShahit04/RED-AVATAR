import 'package:redavatar/pages/chat.dart';
import 'package:redavatar/pages/donate.dart';
import 'package:redavatar/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:redavatar/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.red[200],
            textTheme: TextTheme(
                bodyText1: TextStyle(fontSize: 20.0),
                bodyText2:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))),
        home: NavApp());
  }
}

class NavApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavAppState();
}

class _NavAppState extends State<NavApp> {
  int _selectedPage = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DonatePage(),
    SearchPage(),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          child: Text('Red Avatar'),
          alignment: Alignment.topCenter,
        ),
      ),
      body: _widgetOptions.elementAt(_selectedPage),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), title: Text('Donate')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('search')),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Chat')),
        ],
        currentIndex: _selectedPage,
        onTap: _changeTab,
      ),
    );
  }

  void _changeTab(int value) {
    setState(() {
      _selectedPage = value;
    });
  }
}
