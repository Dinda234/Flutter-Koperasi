import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NasabahPage extends StatefulWidget {
  @override
  _NasabahPageState createState() => _NasabahPageState();
}

class _NasabahPageState extends State<NasabahPage> {
  List<NasabahModel> nasabahList = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    nasabahList = [
      // Contoh data nasabah
      NasabahModel(
        noAnggota: 'SM-001',
        nama: 'Dinda Lestari',
        email: 'Dinda@example.com',
        alamat: 'Jakarta',
        jenisKelamin: 'Perempuan',
        status: 'Aktif',
      ),
    ];
    getDataNasabah();
  }

  Future<void> getDataNasabah() async {
    final url = 'http://192.168.0.109/api_nasabah/read.php'; // Ganti dengan URL backend Anda

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          nasabahList = data.map((item) => NasabahModel.fromJson(item)).toList();
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data: Server error';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load data: $error';
      });
    }
  }

  void _addNasabah(NasabahModel nasabah) {
    setState(() {
      nasabahList.add(nasabah);
    });
  }

  void _showAddNasabahDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddNasabahDialog(onAdd: _addNasabah);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Nasabah'),
      ),
      body: errorMessage.isNotEmpty
          ? Center(
              child: Text(errorMessage),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: nasabahList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(nasabahList[index].nama),
                        subtitle: Text(
                          'Email: ${nasabahList[index].email}\nAlamat: ${nasabahList[index].alamat}\nKelamin: ${nasabahList[index].jenisKelamin}\nStatus: ${nasabahList[index].status}',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailNasabahPage(nasabahList[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _showAddNasabahDialog,
                  child: Text('Tambah Data'),
                ),
              ],
            ),
    );
  }
}

class NasabahModel {
  final String noAnggota;
  final String nama;
  final String email;
  final String alamat;
  final String jenisKelamin;
  final String status;

  NasabahModel({
    required this.noAnggota,
    required this.nama,
    required this.email,
    required this.alamat,
    required this.jenisKelamin,
    required this.status,
  });

  factory NasabahModel.fromJson(Map<String, dynamic> json) {
    return NasabahModel(
      noAnggota: json['no_anggota'],
      nama: json['nama'],
      email: json['email'],
      alamat: json['alamat'],
      jenisKelamin: json['jenis_kelamin'],
      status: json['status'],
    );
  }
}

class AddNasabahDialog extends StatefulWidget {
  final Function(NasabahModel) onAdd;

  AddNasabahDialog({required this.onAdd});

  @override
  _AddNasabahDialogState createState() => _AddNasabahDialogState();
}

class _AddNasabahDialogState extends State<AddNasabahDialog> {
  final _formKey = GlobalKey<FormState>();
  final _noAnggotaController = TextEditingController();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _alamatController = TextEditingController();
  final _jenisKelaminController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void dispose() {
    _noAnggotaController.dispose();
    _namaController.dispose();
    _emailController.dispose();
    _alamatController.dispose();
    _jenisKelaminController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final nasabah = NasabahModel(
        noAnggota: _noAnggotaController.text,
        nama: _namaController.text,
        email: _emailController.text,
        alamat: _alamatController.text,
        jenisKelamin: _jenisKelaminController.text,
        status: _statusController.text,
      );
      widget.onAdd(nasabah);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Nasabah'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _noAnggotaController,
                decoration: InputDecoration(labelText: 'No Anggota'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No Anggota harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jenisKelaminController,
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis Kelamin harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Status harus diisi';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text('Tambah'),
        ),
      ],
    );
  }
}

class DetailNasabahPage extends StatefulWidget {
  final NasabahModel nasabah;

  DetailNasabahPage(this.nasabah);

  @override
  _DetailNasabahPageState createState() => _DetailNasabahPageState();
}

class _DetailNasabahPageState extends State<DetailNasabahPage> {
  bool isSaved = false;

  void _saveData() {
    setState(() {
      isSaved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Nasabah'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No. Anggota: ${widget.nasabah.noAnggota}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Nama: ${widget.nasabah.nama}'),
            SizedBox(height: 10),
            Text('Email: ${widget.nasabah.email}'),
            SizedBox(height: 10),
            Text('Alamat: ${widget.nasabah.alamat}'),
            SizedBox(height: 10),
            Text('Jenis Kelamin: ${widget.nasabah.jenisKelamin}'),
            SizedBox(height: 10),
            Text('Status: ${widget.nasabah.status}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveData,
              child: Text('Simpan Data'),
            ),
            if (isSaved)
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Data telah disimpan!',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Struk telah keluar!',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
