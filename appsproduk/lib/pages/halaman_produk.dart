import 'dart:convert';

import 'package:appsproduk/pages/detail_produk.dart';
import 'package:appsproduk/pages/edit_produk.dart';
import 'package:appsproduk/pages/tambah_produk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanProduk extends StatefulWidget {
  const HalamanProduk({super.key});

  @override
  State<HalamanProduk> createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanProduk> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    try {
      final respon = await http.get(
        Uri.parse('http://192.168.1.2/api_for_flutter/read.php'));
        if (respon.statusCode == 200) {
          final data = jsonDecode(respon.body);
          setState(() {
            _listdata = data;
            _loading = false; 
          });
        }
    } catch (e) {
      print(e);
    }
  }

  Future _delete(String id) async {
    try {
      final respon = await 
      http.post(Uri.parse('http://192.168.1.2/api_for_flutter/delete.php'),
      body: {
        "id_produk" : id,
      }
      );
      if (respon.statusCode == 200) {
        return true;
      } else{
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState (){
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Daftar Produk'
            )
          ),
        backgroundColor: Colors.blueGrey,
      ),
      body: _loading ?  const Center(
        child: CircularProgressIndicator(),
      )
      :ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: ((context, index) {
          return Card(
            child:  InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailProduk(
                        ListData: {
                          'id_produk' : _listdata[index]['id_produk'],
                          'name_produk': _listdata[index]['name_produk'],
                          'harga_produk': _listdata[index]['harga_produk'],
                        },
                      )),
                );
              },
              child: ListTile(
                title: Text(_listdata[index]['name_produk']),
                subtitle: Text(_listdata[index]['harga_produk']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => EditProduk(
                              ListData: {
                              'id_produk': _listdata[index]['id_produk'],
                              'name_produk': _listdata[index]['name_produk'],
                              'harga_produk': _listdata[index]['harga_produk'],
                              },
                            )));
                      },
                      icon: Icon(Icons.edit)
                    ),
                    
                    IconButton(
                      onPressed: (){
                        showDialog(
                          barrierDismissible: false,
                          context: context, 
                          builder: (context){
                            return AlertDialog(
                              content: Text('Hapus Data Ini ?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: (){
                                    _delete(_listdata[index]['id_produk']).then((value){
                                      Navigator.pushAndRemoveUntil(
                                        context, MaterialPageRoute(
                                          builder: ((context) => HalamanProduk())), 
                                          (route) => false);
                                    });
                                  }, 
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red
                                  ),
                                  child: Text('Hapus')
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Batal')),
                              ],
                            );
                          }
                        );
                      }, 
                      icon: Icon(Icons.delete)
                    ),
                  ],
                ),
              ),
            ),
            
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) =>  const TambahProduk()
            ),
          );
        },
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 24
          ),
          ),
      ),
    );
  }
}