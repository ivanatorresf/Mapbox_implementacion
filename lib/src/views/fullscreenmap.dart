import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/provider/dataProvider.dart';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  LatLng latinoamerica = LatLng(23.005903, -102.160759);

  String selectedStyle =
      'mapbox://styles/ivanflores2021/ckkcw6o2204wr17rqyhhy9gd5';
  final oscuroStyle =
      'mapbox://styles/ivanflores2021/ckkcvuuoq02ql17o8y4gd1s8k';
  final streetStyle =
      'mapbox://styles/ivanflores2021/ckkcw6o2204wr17rqyhhy9gd5';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(url);
    return mapController.addImage(name, response.bodyBytes);
  }

  Size media;
  double r, rh;

  initTheme(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    r = media.width;
    rh = media.height;
  }

  PageController pageCards=PageController();
  List<Widget> listCards = [];
  int currentPage;

  @override
  void initState() {
    currentPage=0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initTheme(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Boutiques')),
        body: crearMapa(),
        floatingActionButton: botonesFlotantes(),
        bottomNavigationBar: cardBody());
  }

  Column botonesFlotantes() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      FloatingActionButton(
        child: Icon(Icons.zoom_in),
        onPressed: () {
          mapController.animateCamera(CameraUpdate.zoomIn());
        },
      ),
      FloatingActionButton(
        child: Icon(Icons.zoom_out),
        onPressed: () {
          mapController.animateCamera(CameraUpdate.zoomOut());
        },
      ),
      FloatingActionButton(
          child: Icon(Icons.add_to_home_screen),
          onPressed: () {
            if (selectedStyle == oscuroStyle) {
              selectedStyle = streetStyle;
            } else {
              selectedStyle = oscuroStyle;
            }

            setState(() {});
          }),
      FloatingActionButton(
        child: Icon(Icons.account_balance),
        onPressed: () {
          mapController.addSymbol(SymbolOptions(
            geometry: latinoamerica,
            iconImage: 'assetImage',
            iconSize: 0.7,
            textField: 'Beverly Hills',
            textOffset: Offset(0, 2),
          ));
        },
      ),
      //_cardTipo1(),
    ]);
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: latinoamerica, zoom: 3),
    );
  }

  Widget cardBody() {
    return Container(
      width: r,
      height: 0.5*r,
      child: Stack(
        children: [
          FutureBuilder(
            future: dataProvider.cargarDatos(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
              snapshot.data.forEach((data) {
                  var ubicacion = data['ubicacion'].toString().split(':');
                  String latitude = ubicacion[0].trim();
                  String longitude = ubicacion.sublist(1).join(', ').trim();

                  listCards.add(card(data['title'], data['description'], LatLng(double.parse(latitude), double.parse(longitude))));
              });
              if(snapshot.hasData){
                return PageView(
                  controller: pageCards,
                  children: listCards,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }
          ),
          btnLeft(),
          btnRight()
        ],
      ),
    );
  }

  Widget card(String title, desc, LatLng ubicacion) {
    return Container(width: r, height: 0.05*r,
      child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text(title),
          subtitle: Text(desc),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.animateCamera(CameraUpdate.newLatLngZoom(ubicacion, 10));
                  mapController.addSymbol(SymbolOptions(
                    geometry: ubicacion,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: title,
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget btnLeft(){
    return Positioned(left: 0, top: 0.09*rh,
      child: Container(
        width: 0.12*r, height: 0.15*r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.1*r)
        ),
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.1*r)),
          onPressed: (){
            pageCards.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
          },
          child: Icon(CupertinoIcons.left_chevron, color: Colors.black87, size: 0.1*r)),
      ),
    );
  }

  Widget btnRight(){
    print('data ${listCards.length}');
    return Positioned(right: 0, top: 0.09*rh,
      child: Container(
        width: 0.12*r, height: 0.15*r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.1*r)
        ),
        child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.1*r)),
          onPressed: (){
            pageCards.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
          },
          child: Icon(CupertinoIcons.right_chevron, color: Colors.black87, size: 0.1*r)),
      ),
    );
  }
}
