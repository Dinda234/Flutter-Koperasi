import 'package:flutter/material.dart';

class PembayaranPage extends StatefulWidget {
  @override
  _PembayaranPageState createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  List<NasabahModel> nasabahList = [];

  @override
  void initState() {
    super.initState();
    getDataNasabah();
  }

  Future<void> getDataNasabah() async {
    // Simulasi data nasabah dari sumber data (misalnya: database)
    setState(() {
      nasabahList = [
        NasabahModel(id: 1, nama: 'Nanda', iuran: 500000),
        NasabahModel(id: 2, nama: 'Najwa', iuran: 750000),
        NasabahModel(id: 3, nama: 'Dinda', iuran: 600000),
      ];
    });
  }

  Future<void> tambahNasabah(NasabahModel nasabah) async {
    // Simulasi penambahan nasabah ke sumber data
    setState(() {
      nasabahList.add(nasabah);
    });
  }

  Future<void> hapusNasabah(int id) async {
    // Simulasi penghapusan nasabah dari sumber data berdasarkan ID
    setState(() {
      nasabahList.removeWhere((nasabah) => nasabah.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: ListView.builder(
        itemCount: nasabahList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(nasabahList[index].nama),
            subtitle: Text('Iuran Pinjaman: Rp ${nasabahList[index].iuran}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPembayaranPage(nasabahList[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman tambah nasabah
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahNasabahPage(tambahNasabah),
            ),
          ).then((value) {
            // Ketika kembali dari halaman tambah nasabah, perbarui tampilan jika ada perubahan
            if (value != null && value) {
              getDataNasabah();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NasabahModel {
  final int id;
  final String nama;
  final int iuran;

  NasabahModel({
    required this.id,
    required this.nama,
    required this.iuran,
  });
}

class DetailPembayaranPage extends StatelessWidget {
  final NasabahModel nasabah;

  DetailPembayaranPage(this.nasabah);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pembayaran'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nama Nasabah: ${nasabah.nama}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Iuran Pinjaman: Rp ${nasabah.iuran}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol pembayaran ditekan
              },
              child: Text('Bayar Iuran'),
            ),
            ElevatedButton(
              onPressed: () {
                // Tampilkan dialog konfirmasi hapus nasabah
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Konfirmasi Hapus Nasabah'),
                    content: Text('Apakah Anda yakin ingin menghapus nasabah ini?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Panggil fungsi hapus nasabah
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Nasabah ${nasabah.nama} dihapus'),
                          ));
                        },
                        child: Text('Hapus'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Hapus Nasabah'),
            ),
          ],
        ),
      ),
    );
  }
}

class TambahNasabahPage extends StatefulWidget {
  final Function(NasabahModel) tambahNasabah;

  TambahNasabahPage(this.tambahNasabah);

  @override
  _TambahNasabahPageState createState() => _TambahNasabahPageState();
}

class _TambahNasabahPageState extends State<TambahNasabahPage> {
  final TextEditingController _controllerNama = TextEditingController();
  final TextEditingController _controllerIuran = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Nasabah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controllerNama,
              decoration: InputDecoration(labelText: 'Nama Nasabah'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controllerIuran,
              decoration: InputDecoration(labelText: 'Iuran Pinjaman'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validasi input
                if (_controllerNama.text.isNotEmpty &&
                    _controllerIuran.text.isNotEmpty) {
                  // Panggil fungsi tambah nasabah
                  NasabahModel newNasabah = NasabahModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    nama: _controllerNama.text,
                    iuran: int.parse(_controllerIuran.text),
                  );
                  widget.tambahNasabah(newNasabah);
                  Navigator.of(context).pop(true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Nama dan Iuran tidak boleh kosong'),
                  ));
                }
              },
              child: Text('Tambah Nasabah'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PembayaranPage(),
  ));
}
