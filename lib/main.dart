import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

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
      home: ShowCaseWidget(
        onStart: (_, __) {
          print('<<<<<<<<<<<');
          print('start');
          print('<<<<<<<<<<<');
        },
        onFinish: () {
          print('<<<<<<<<<<<');
          print('finish');
          print('<<<<<<<<<<<');
        },
        onComplete: (_, __) {
          print('<<<<<<<<<<<');
          print('complete');
          print('<<<<<<<<<<<');
        },
        builder: Builder(
          builder: (context) {
            return const MyHomePage(title: 'showcaseview demo');
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ShowCaseWidget.of(context)!.startShowCase([_key1, _key2]);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Showcase(
            key: _key1,
            description: 'description',
            onToolTipClick: () {
              ShowCaseWidget.of(context)?.next();
            },
            child: IconButton(
              onPressed: () {
                ShowCaseWidget.of(context)?.startShowCase([_key1]);
              },
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'item1'),
          BottomNavigationBarItem(icon: Icon(Icons.accessibility), label: 'item2'),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                ShowCaseWidget.of(context)?.startShowCase([_key1, _key2]);
              },
              child: const Text('Start ShowCase'),
            ),
          ],
        ),
      ),
      floatingActionButton: Showcase.withWidget(
        key: _key2,
        description: 'desc',
        shapeBorder: const CircleBorder(),
        width: 300,
        height: 300,
        container: Container(
          child: Column(
            children: [
              const Text('Title', style: TextStyle(color: Colors.white)),
              ElevatedButton(
                onPressed: () {
                  ShowCaseWidget.of(context)?.previous();
                },
                child: const Text('Prev ShowCase'),
              ),
            ],
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            ShowCaseWidget.of(context)!.startShowCase([_key1, _key2]);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
