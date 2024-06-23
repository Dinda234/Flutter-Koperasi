import 'package:flutter/material.dart';

class PenarikanPage extends StatefulWidget {
  @override
  _PenarikanPageState createState() => _PenarikanPageState();
}

class _PenarikanPageState extends State<PenarikanPage> {
  List<NasabahModel> nasabahList = [
    NasabahModel(nama: 'Dinda Lestari', saldo: 1000000),
    NasabahModel(nama: 'Nanda Binari', saldo: 2000000),
    NasabahModel(nama: 'Najwa Putri', saldo: 1500000),
  ]; // Data nasabah simulasi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penarikan'),
      ),
      body: ListView.builder(
        itemCount: nasabahList.length,
        itemBuilder: (context, index) {
          // Tampilkan data nasabah dalam ListTile
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(nasabahList[index].nama),
            subtitle: Text('Saldo: Rp ${nasabahList[index].saldo}'),
            onTap: () {
              // Navigasi ke halaman detail penarikan nasabah
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPenarikanPage(nasabahList[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NasabahModel {
  final String nama;
  int saldo;

  NasabahModel({
    required this.nama,
    required this.saldo,
  });
}

class DetailPenarikanPage extends StatefulWidget {
  final NasabahModel nasabah;

  DetailPenarikanPage(this.nasabah);

  @override
  _DetailPenarikanPageState createState() => _DetailPenarikanPageState();
}

class _DetailPenarikanPageState extends State<DetailPenarikanPage> {
  TextEditingController _jumlahController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Penarikan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nama Nasabah: ${widget.nasabah.nama}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Saldo: Rp ${widget.nasabah.saldo}'),
            SizedBox(height: 20),
            TextFormField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Penarikan',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _tarikSaldo();
              },
              child: Text('Tarik Saldo'),
            ),
          ],
        ),
      ),
    );
  }

  void _tarikSaldo() {
    int jumlah = int.tryParse(_jumlahController.text) ?? 0;
    if (jumlah > 0 && jumlah <= widget.nasabah.saldo) {
      setState(() {
        widget.nasabah.saldo -= jumlah;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saldo berhasil ditarik sebesar Rp $jumlah'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Jumlah penarikan tidak valid'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
