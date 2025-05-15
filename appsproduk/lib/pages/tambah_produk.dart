import 'package:appsproduk/pages/halaman_produk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahProduk extends StatefulWidget {
  const TambahProduk({super.key});

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();

  Future _simpan () async {
    final respon = await http.post(
      Uri.parse('http://192.168.1.2/api_for_flutter/create.php'),
      body: {
        'name_produk' : nama_produk.text,
        'harga_produk': harga_produk.text 
      });
      if (respon.statusCode == 200){
        return true;
      }
      return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama_produk,
                decoration: InputDecoration(
                  hintText: 'Silahkan Tambah Nama Baru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
                validator: (value) {
                  if (value!.isEmpty){
                    return "Field Ini Harus Terisi Dengan Baik!!";
                  }
                },
              ),
              const SizedBox(height: 17),

              TextFormField(
                  controller: harga_produk,
                  decoration: InputDecoration(
                      hintText: 'Silahkan Tambah Harga Baru',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field Ini Harus Terisi Dengan Baik!!";
                    }
                  },
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  onPressed: (){
                    if (formKey.currentState!.validate()){
                      _simpan().then((value) {
                        if (value){
                          final snackBar = SnackBar(content: 
                          const Text ('Data Berhasil Disimpan'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          final snackBar = SnackBar(
                          content: const Text('Data Gagal Disimpan'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                      Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(
                          builder: ((context) => HalamanProduk())),
                          (route) => false
                      );
                    }
                  }, 
                  child: Text('Simpan')
              )
            ],
          ),
        )
      ),
    );
  }
}