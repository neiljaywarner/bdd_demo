import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String title = '[Cached]MV Ref Poc of Concept1';
String text = '';
String reference = '';
bool isLoading = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Always try to fetch fresh data first
  await fetchData();
  
  // If fetch failed and no data was loaded, then try from cache
  if (text.isEmpty || reference.isEmpty) {
    await _loadFromSharedPreferences();
  }

  runApp(const MyApp());
}

Future<void> fetchData({http.Client? client}) async {
  final httpClient = client ?? http.Client();

  try {
    final response = await httpClient.get(
      Uri.parse('https://gist.githubusercontent.com/neiljaywarner/2880b87250163386a41e00fc1535e02c/raw/90c2b1b45a53133e6c61384d9d5f6028fefa18b2/miniverses1.json'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final item = data[1];
        text = item['text'];
        reference = item['ref'];

        // Save to SharedPreferences for offline use
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('text', text);
        await prefs.setString('reference', reference);
      }
    } else {
      // Network request failed, try loading from SharedPreferences
      await _loadFromSharedPreferences();
      print('Failed to load data from network: ${response.statusCode}. Using cached data if available.');
    }
  } catch (e) {
    // Error (likely network related), try loading from SharedPreferences
    await _loadFromSharedPreferences();
    print('Error fetching data (offline?): $e. Using cached data if available.');
  } finally {
    if (client == null) {
      httpClient.close();
    }
  }
}

// Helper function to load from SharedPreferences
Future<void> _loadFromSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final savedText = prefs.getString('text');
  final savedReference = prefs.getString('reference');
  
  if (savedText != null && savedReference != null) {
    text = savedText;
    reference = savedReference;
    print('Successfully loaded cached data');
  } else {
    print('No cached data available');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', text: text, reference: reference),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.text, required this.reference});
  final String title;
  final String text;
  final String reference;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _result = '';

  void _checkReference(String guessedReference) {
    setState(() {
      if (widget.reference == guessedReference) {
        _result = 'Correct';
      } else {
        _result = '';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Try to fetch fresh data first
      await fetchData();
    } catch (e) {
      print('Error in _loadData: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    body: Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    key: const ValueKey('Reference'),
                    decoration: const InputDecoration(
                      hintText: 'Reference',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _checkReference,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _result,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
    ),
  );
}
