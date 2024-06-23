import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'simpanan.dart';
import 'editprofile.dart';
import 'pinjaman.dart';
import 'pembayaran.dart';
import 'penarikan.dart';
import 'nasabah.dart';
import 'laporan.dart';
import 'livechat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koperasi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false, // Remove the debug banner
    );
  }
}

class MyHomePage extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF64B5F6), // Warna gradien atas
      ),
      body: PageView(
        controller: _pageController,
        children: [
          AdvertisementPage(),
          LoginPage(), // Menambahkan halaman pendaftaran di sini
        ],
      ),
    );
  }
}

class AdvertisementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF64B5F6), // Ubah warna sesuai keinginan Anda
            const Color(0xFF0D47A1), // Ubah warna sesuai keinginan Anda
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Judul Koperasiku
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Koperasiku',
              style: TextStyle(
                fontSize: 45, // Sesuaikan ukuran font dengan preferensi Anda
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily:
                    'Oswald', // Ganti dengan nama font yang Anda inginkan
              ),
            ),
          ),
          // Gambar
          Center(
            child: Image.asset(
              'assets/images/koperasi.jpg',
              width: 200,
              height: 200,
            ),
          ),
          // Deskripsi
          const SizedBox(height: 20),
          const Text(
            'DP mulai dari RpO\nLimit hingga 25 juta untuk cicilan\nonline dan offline',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passController = TextEditingController();

  static Future<void> login(BuildContext context) async {
    var url = "http://192.168.100.149/koperasiku/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": emailController.text,
      "password": passController.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(
          msg: "Email & Password Incorrect!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromARGB(255, 8, 104, 182),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF64B5F6), // Warna AppBar
        toolbarHeight: 10,
        title: Text(
          'KoperasiKu', // Judul AppBar
          style: TextStyle(
              color: Colors.white, // Warna teks judul
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) => HomePage()),
                  );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Signup here',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  void navigateToSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }
}

class SignupPage extends StatelessWidget {
  static TextEditingController usernameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passController = TextEditingController();

  static Future<void> signup(BuildContext context) async {
    var url = "http://192.168.100.149/koperasiku/signup.php";
    var response = await http.post(Uri.parse(url), body: {
      "username": usernameController.text,
      "email": emailController.text,
      "password": passController.text,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      Fluttertoast.showToast(
          msg: "Signup Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(
          msg: "Invalid Username or Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signup Here',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF64B5F6), // Warna AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Login',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                signup(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Signup',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Koperasi',
          style: TextStyle(
            color: Colors.white, // Ubah warna teks menjadi putih
          ),
        ),
        backgroundColor:
            const Color.fromARGB(255, 8, 104, 182), // Warna latar belakang biru
        actions: [
          IconButton(
            icon: const Icon(Icons.person,
                color: Colors.white), // Ubah ikon menjadi pengaturan
            onPressed: () {
              // Aksi ketika tombol pengaturan ditekan
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Aksi ketika tombol Simpanan ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SimpananPage()),
                );
              },
              icon: const Icon(Icons.account_balance_wallet,
                  color: Color.fromARGB(
                      255, 8, 104, 182)), // Ubah warna ikon menjadi biru
              label: const Text(
                'Simpanan',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 8, 104, 182)), // Ubah warna teks menjadi biru
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Aksi ketika tombol Pinjaman ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PinjamanPage()),
                );
              },
              icon: const Icon(Icons.monetization_on,
                  color: Color.fromARGB(
                      255, 8, 104, 182)), // Ubah warna ikon menjadi biru
              label: const Text(
                'Pinjaman',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 8, 104, 182)), // Ubah warna teks menjadi biru
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Aksi ketika tombol Pembayaran ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PembayaranPage()),
                );
              },
              icon: const Icon(Icons.payment,
                  color: Color.fromARGB(
                      255, 8, 104, 182)), // Ubah warna ikon menjadi biru
              label: const Text(
                'Pembayaran',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 8, 104, 182)), // Ubah warna teks menjadi biru
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Aksi ketika tombol Penarikan ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PenarikanPage()),
                );
              },
              icon: const Icon(Icons.money_off,
                  color: Color.fromARGB(
                      255, 8, 104, 182)), // Ubah warna ikon menjadi biru
              label: const Text(
                'Penarikan',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 8, 104, 182)), // Ubah warna teks menjadi biru
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Aksi ketika tombol Nasabah ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NasabahPage()),
                );
              },
              icon: const Icon(Icons.people,
                  color: Color.fromARGB(
                      255, 8, 104, 182)), // Ubah warna ikon menjadi biru
              label: const Text(
                'Nasabah',
                style: TextStyle(
                    color: Color.fromARGB(
                        255, 8, 104, 182)), // Ubah warna teks menjadi biru
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi ketika tombol Live Chat ditekan
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LiveChatPage()),
          );
        },
        tooltip: 'Live Chat',
        child: const Icon(Icons.chat,
            color: Color.fromARGB(
                255, 8, 104, 182)), // Ubah warna ikon menjadi biru
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(
            255, 8, 104, 182), // Warna latar belakang navbar biru
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // Aksi ketika tombol home ditekan
              },
            ),
            IconButton(
              icon: const Icon(Icons.analytics, color: Colors.white),
              onPressed: () {
                // Aksi ketika tombol laporan ditekan
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LaporanPage()));
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: GestureDetector(
                onTap: () {
                  // Aksi ketika foto profil pada slidebar ditekan
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KoperasiKu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/profile_picture.jpg'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Nama Admin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      'admin@koperasiku.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Maps'),
              onTap: () {
                // Aksi ketika menu maps dipilih
                // Navigasi ke halaman maps di sini
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Aksi ketika menu logout dipilih
                // Lakukan penanganan logout di sini
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 8, 104, 182),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nama Pengguna',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'email@example.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman edit profil saat tombol ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
              child: const Text('Edit Profil'),
            ),
          ],
        ),
      ),
    );
  }
}