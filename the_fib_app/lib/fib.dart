import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _n = 0;
  List<int> _sequence = [];

  void _generateSequence() {
    List<int> sequence = [];

    int first = 0, second = 1, next;
    for (int i = 0; i < _n; i = i + 1) {
      if (i <= 1) {
        next = i;
      } else {
        next = first + second;
        first = second;
        second = next;
      }
      setState(() {
        sequence.add(next);
      });
    }
    setState(
      () {
        _sequence = sequence;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          elevation: null,
          title: const Text('Fibonacci App'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter the number of terms you want to generate in the Fibonacci sequence:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        hintText: 'No. of terms',
                        hintStyle: const TextStyle(color: Colors.red),
                        contentPadding: const EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _n = 0;
                        } else if (int.tryParse(value) == null) {
                          throw Exception();
                        } else {
                          _n = int.parse(value);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _generateSequence();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: const Text(
                        'Generate',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'The first $_n terms of the Fibonacci sequence are:',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          _sequence.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
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
