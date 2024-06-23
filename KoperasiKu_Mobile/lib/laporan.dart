import 'package:flutter/material.dart';

class LaporanPage extends StatefulWidget {
  @override
  _LaporanPageState createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Laporan Pinjaman'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LaporanPinjamanPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.money_off),
            title: Text('Laporan Penarikan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LaporanPenarikanPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Laporan Simpanan'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LaporanSimpananPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class LaporanPinjamanPage extends StatefulWidget {
  @override
  _LaporanPinjamanPageState createState() => _LaporanPinjamanPageState();
}

class _LaporanPinjamanPageState extends State<LaporanPinjamanPage> {
  List<PinjamanModel> _pinjamanList = [];

  @override
  void initState() {
    super.initState();
    // Load data pinjaman
    _loadPinjamanData();
  }

  void _loadPinjamanData() {
    // Simulasi data pinjaman
    setState(() {
      _pinjamanList = [
        PinjamanModel(id: 1, nasabah: 'John Doe', jumlah: 1000000),
        PinjamanModel(id: 2, nasabah: 'Jane Smith', jumlah: 1500000),
      ];
    });
  }

  void _tambahPinjaman(PinjamanModel pinjaman) {
    // Simulasi penambahan data pinjaman
    setState(() {
      _pinjamanList.add(pinjaman);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Pinjaman'),
      ),
      body: ListView.builder(
        itemCount: _pinjamanList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_pinjamanList[index].nasabah),
            subtitle: Text('Jumlah: ${_pinjamanList[index].jumlah}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman tambah pinjaman
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahPinjamanPage(_tambahPinjaman),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class LaporanPenarikanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tampilkan laporan penarikan
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Penarikan'),
      ),
      body: Center(
        child: Text('Halaman Laporan Penarikan'),
      ),
    );
  }
}

class LaporanSimpananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tampilkan laporan simpanan
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Simpanan'),
      ),
      body: Center(
        child: Text('Halaman Laporan Simpanan'),
      ),
    );
  }
}

class PinjamanModel {
  final int id;
  final String nasabah;
  final int jumlah;

  PinjamanModel({
    required this.id,
    required this.nasabah,
    required this.jumlah,
  });
}

class TambahPinjamanPage extends StatefulWidget {
  final Function(PinjamanModel) tambahPinjaman;

  TambahPinjamanPage(this.tambahPinjaman);

  @override
  _TambahPinjamanPageState createState() => _TambahPinjamanPageState();
}

class _TambahPinjamanPageState extends State<TambahPinjamanPage> {
  final TextEditingController _controllerNasabah = TextEditingController();
  final TextEditingController _controllerJumlah = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pinjaman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controllerNasabah,
              decoration: InputDecoration(labelText: 'Nama Nasabah'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controllerJumlah,
              decoration: InputDecoration(labelText: 'Jumlah Pinjaman'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_controllerNasabah.text.isNotEmpty &&
                    _controllerJumlah.text.isNotEmpty) {
                  PinjamanModel newPinjaman = PinjamanModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    nasabah: _controllerNasabah.text,
                    jumlah: int.parse(_controllerJumlah.text),
                  );
                  widget.tambahPinjaman(newPinjaman);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Nama dan Jumlah tidak boleh kosong'),
                  ));
                }
              },
              child: Text('Tambah Pinjaman'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LaporanPage(),
  ));
}
