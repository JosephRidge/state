import 'package:flutter/material.dart';
import 'package:state/core/change_notifiers/counter.dart';
import 'package:state/models/album.dart';
import '../utility/globals.dart' as globals;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.onChanged});
  final String title;
  final ValueChanged<int> onChanged;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CounterNotifier counterNotifier = CounterNotifier();
  late Future<Album> albums;

  @override
  void initState() {
    super.initState();
    albums = globals.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<Album>(
              future: albums,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.title);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            Text('You have pushed the button this many times:'),
            ListenableBuilder(
              listenable: counterNotifier,
              builder: (context, child) {
                return Text(
                  '${counterNotifier.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterNotifier.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
