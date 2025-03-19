import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController namaController = TextEditingController();
  final key = GlobalKey<FormState>();
  List<String> daftarNama = [];

  void addData() {
    setState(() {
      daftarNama.add(namaController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/katana.jpg'),
                  ),
                  Text('Katana'),
                ],
              ),
              Form(
                key: key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: namaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama masih kosong!';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          label: Text('Nama Pendaftar'),
                          hintText: 'Masukkan nama lengkap pendaftar',
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          addData();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: ListView.builder(
                  itemCount: daftarNama.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent[100],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(daftarNama[index])]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
