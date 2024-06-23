import 'package:flutter/material.dart';

class SimpananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simpanan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 8, 104, 182),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Detail Simpanan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SimpananCard(
              title: 'Simpanan Pokok',
              amount: 5000000,
            ),
            SimpananCard(
              title: 'Simpanan Wajib',
              amount: 1000000,
            ),
            SimpananCard(
              title: 'Simpanan Sukarela',
              amount: 2000000,
            ),
          ],
        ),
      ),
    );
  }
}

class SimpananCard extends StatelessWidget {
  final String title;
  final int amount;

  SimpananCard({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Jumlah: Rp $amount',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol detail ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailSimpananPage(title: title, amount: amount)),
                );
              },
              child: Text('Detail'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailSimpananPage extends StatelessWidget {
  final String title;
  final int amount;

  DetailSimpananPage({required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Simpanan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 8, 104, 182),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Jenis Simpanan: $title',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Jumlah: Rp $amount',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              // Tambahkan detail lainnya sesuai kebutuhan
            ],
          ),
        ),
      ),
    );
  }
}
