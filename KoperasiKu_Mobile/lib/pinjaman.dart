import 'package:flutter/material.dart';

class PinjamanPage extends StatefulWidget {
  @override
  _PinjamanPageState createState() => _PinjamanPageState();
}

class _PinjamanPageState extends State<PinjamanPage> {
  List<PinjamanModel> pinjamanList =
      []; // PinjamanModel adalah model data pinjaman

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mendapatkan data pinjaman dari backend
    getDataPinjaman();
  }

  Future<void> getDataPinjaman() async {
    // Lakukan permintaan HTTP ke backend untuk mendapatkan data pinjaman
    // Gunakan setState untuk memperbarui state widget dengan data terbaru
    setState(() {
      // Perbarui pinjamanList dengan data yang diterima dari backend
      // Misalnya, menggunakan package http untuk melakukan permintaan HTTP
      // http.get('URL_BACKEND').then((response) {
      //   if (response.statusCode == 200) {
      //     // Parse data response ke dalam List<PinjamanModel>
      //     // pinjamanList = parseResponse(response.body);
      //   } else {
      //     throw Exception('Failed to load data');
      //   }
      // }).catchError((error) {
      //   throw Exception('Failed to load data: $error');
      // });
      pinjamanList = [
        PinjamanModel(id: 1, jumlah: 20000, bunga: 10),
        PinjamanModel(id: 2, jumlah: 5000000, bunga: 10),
        PinjamanModel(id: 3, jumlah: 3000000, bunga: 10),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pinjaman'),
      ),
      body: ListView.builder(
        itemCount: pinjamanList.length,
        itemBuilder: (context, index) {
          // Tampilkan data pinjaman dalam ListTile
          return ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Pinjaman ${pinjamanList[index].id}'),
            subtitle: Text('Jumlah: ${pinjamanList[index].jumlah}'),
            trailing: Text('Bunga: ${pinjamanList[index].bunga}%'),
            onTap: () {
              // Navigasi ke halaman detail pinjaman
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPinjamanPage(pinjamanList[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PinjamanModel {
  final int id;
  final int jumlah;
  final double bunga;

  PinjamanModel({
    required this.id,
    required this.jumlah,
    required this.bunga,
  });
}

class DetailPinjamanPage extends StatelessWidget {
  final PinjamanModel pinjaman;

  DetailPinjamanPage(this.pinjaman);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pinjaman'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pinjaman ${pinjaman.id}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Jumlah: ${pinjaman.jumlah}'),
            SizedBox(height: 10),
            Text('Bunga: ${pinjaman.bunga}%'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol pembayaran ditekan
              },
              child: Text('Bayar Pinjaman'),
            ),
          ],
        ),
      ),
    );
  }
}