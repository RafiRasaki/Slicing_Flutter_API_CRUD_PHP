import 'package:flutter/material.dart';

class DetailProduk extends StatefulWidget {

  final Map ListData;
  DetailProduk({Key? key,
  required this.ListData
  }) : super(key: key);

  //const DetailProduk({super.key});

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id_produk = TextEditingController();
  TextEditingController nama_produk = TextEditingController();
  TextEditingController harga_produk = TextEditingController();

  @override
  Widget build(BuildContext context) {
    id_produk.text = widget.ListData['id_produk'];
    nama_produk.text = widget.ListData['name_produk'];
    harga_produk.text = widget.ListData['harga_produk'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        backgroundColor: Colors.blueGrey,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('ID Produk'),
                  subtitle: Text(widget.ListData['id_produk']),
                ),
                ListTile(
                  title: Text('Nama Produk'),
                  subtitle: Text(widget.ListData['name_produk']),
                ),
                ListTile(
                  title: Text('Harga Produk'),
                  subtitle: Text(widget.ListData['harga_produk']),
                ),

                const SizedBox(height: 50),

                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                    ),
                    onPressed: (){
                      print('Sukses Print');
                    }, 
                    child: Text('Print Data Produk'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}