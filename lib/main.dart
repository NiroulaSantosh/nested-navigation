import 'package:flutter/material.dart';

final List<GlobalKey<NavigatorState>> _navKeys = [
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>()
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentTab = 0;
  final pages = [
    HomeScreen(navKey: _navKeys[0]),
    SettingScreen(navKey: _navKeys[1]),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await _navKeys[_currentTab].currentState!.maybePop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("persistent app bar"),
        ),
        body: pages[_currentTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (index) {
            setState(() {
              _currentTab = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.navKey}) : super(key: key);
  final GlobalKey navKey;

  void push() {
    Navigator.pushNamed(
      navKey.currentContext!,
      '/details',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: navKey,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) {
            if (settings.name == '/') {
              return Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(navKey.currentContext!).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeDetailScreen(),
                      ),
                    );
                  },
                  child: const Text('Home detail'),
                ),
              );
            } else if (settings.name == '/details') {
              return const HomeDetailScreen();
            } else {
              throw UnimplementedError();
            }
          });
        },
      ),
    );
  }
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key, required this.navKey}) : super(key: key);
  final GlobalKey navKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navKey,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;

        return true;
      },
      pages: [
        MaterialPage(
          child: Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(navKey.currentContext!).push(
                  MaterialPageRoute(
                    builder: (context) => const SettiingsDetailScreen(),
                  ),
                );
              },
              child: const Text('setting detail'),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeDetailScreen extends StatefulWidget {
  const HomeDetailScreen({Key? key}) : super(key: key);

  @override
  State<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  Future<void> onExitPressed() async {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  bool canExit() {
    return Navigator.canPop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            if (canExit()) {
              await onExitPressed();
            }
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("Home details"),
      ),
      body: const Center(
        child: Text('home page detail'),
      ),
    );
  }
}

class SettiingsDetailScreen extends StatelessWidget {
  const SettiingsDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('settings page detail'),
      ),
    );
  }
}
