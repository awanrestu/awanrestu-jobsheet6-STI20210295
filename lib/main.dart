import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Mahasiswa {
  final String nama;
  final String nim;

  Mahasiswa(this.nama, this.nim);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nama Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
          displayLarge: TextStyle(
            fontSize: 47,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Nama Mahasiswa'),
        ),
        body: const StateTeksUtama(),
      ),
    );
  }
}

class StateTeksUtama extends StatefulWidget {
  const StateTeksUtama({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StateTeksUtamaState createState() => _StateTeksUtamaState();
}

class _StateTeksUtamaState extends State<StateTeksUtama> with SingleTickerProviderStateMixin {
  final List<Mahasiswa> listMahasiswa = [
    Mahasiswa('Awan Restu Listyanto', 'STI202102395'),
    Mahasiswa('Arif Ardi Antoro', 'STI202102246'),
    Mahasiswa('Deni Stiadi', 'STI202102464'),
    Mahasiswa('Latif Kamaludin', 'STI202102264'),
    Mahasiswa('Yusuf Jauhar', 'STI2021102390'),
  ];
  final List<Color> listWarna = [
    Colors.red,
    Colors.purple,
    Colors.teal,
    Colors.blue,
    Colors.orange,
  ];
  int index = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: listWarna[index],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: index == 0 ? _animation : const AlwaysStoppedAnimation(1.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: _calculateFontColor(listWarna[index]),
                  width: 5,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.account_box,
                size: 300,
                color: _calculateFontColor(listWarna[index]),
              ),
            ),
          ),
          const SizedBox(height: 5),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Column(
              key: ValueKey<int>(index),
              children: [
                Text(
                  listMahasiswa[index].nama,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: _calculateFontColor(listWarna[index]),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'NIM: ${listMahasiswa[index].nim}',
                  style: TextStyle(
                    fontSize: 20,
                    color: _calculateFontColor(listWarna[index]),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            onPressed: () {
              setState(() {
                index = (index + 1) % listMahasiswa.length;
                if (index == 0) {
                  _controller.reset();
                  _controller.forward();
                }
              });
            },
            child: const Text('Ganti Nama'),
          ),
        ],
      ),
    );
  }

  Color _calculateFontColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
