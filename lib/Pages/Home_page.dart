import 'package:flutter/material.dart';

import 'package:gifs/Models/Model_Gifs.dart';
import 'package:gifs/Provider/Gif_Provider.dart';
import 'package:gifs/Widgets/listGifs.dart';

class MyHomeApp extends StatefulWidget{
  const MyHomeApp({Key? key, required this.title}): super(key: key);

  final String title;
  @override
  State<MyHomeApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomeApp>{

  late Future<List<ModelGifs>> _listadoGifs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final getprovider = new GifProvider();
    _listadoGifs = getprovider.getGifs();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: _listadoGifs,
        builder: (context, snapshot) {
          if(snapshot.hasData){
              return GridView.count(
                  crossAxisCount: 2,
                children: listGifs(snapshot.data as List<ModelGifs>),
              );
          }else{
              print(snapshot.error);
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

}