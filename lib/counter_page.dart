import 'package:flutter/material.dart';

// Halaman utama counter
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  // List untuk menyimpan nilai counter dalam bentuk string
  List<String> daftarCounter = [];
  // Variabel untuk menyimpan angka counter
  int counter = 1;

  // Fungsi untuk menambah angka counter ke dalam daftar
  void tambahCounter() {
    setState(() {
      daftarCounter.add(counter.toString()); // Menambahkan angka ke daftar
      counter++; // Meningkatkan nilai counter
    });
  }

  // Fungsi untuk mengurangi angka counter dari daftar
  void kurangiCounter() {
    if (daftarCounter.isNotEmpty) { // Memastikan daftar tidak kosong sebelum menghapus
      setState(() {
        daftarCounter.removeLast(); // Menghapus angka terakhir dari daftar
        counter--; // Mengurangi nilai counter
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Page')), // Judul halaman
      body: daftarCounter.isEmpty
          ? const Center(child: Text('Data Kosong')) // Menampilkan pesan jika daftar kosong
          : ListView.builder(
              itemCount: daftarCounter.length, // Menentukan jumlah item dalam daftar
              itemBuilder: (context, index) {
                return ListTile(title: Text(daftarCounter[index])); // Menampilkan setiap angka dalam daftar
              },
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: tambahCounter, // Memanggil fungsi tambahCounter saat tombol ditekan
            child: const Icon(Icons.add), // Ikon tambah
          ),
          const SizedBox(width: 10), // Spasi antara tombol
          FloatingActionButton(
            onPressed: kurangiCounter, // Memanggil fungsi kurangiCounter saat tombol ditekan
            child: const Icon(Icons.remove), // Ikon hapus
          ),
        ],
      ),
    );
  }
}
