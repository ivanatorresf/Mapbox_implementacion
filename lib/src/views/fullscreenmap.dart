import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  final latinoamerica = LatLng(23.005903, -102.160759);
  final centerBH = LatLng(34.0825439, -118.4345535);
  final centerCDMX = LatLng(19.39068, -99.2836999);
  final centerCul = LatLng(24.8049008, -107.4933547);
  final centerElPaTex = LatLng(31.8110563, -106.5646034);
  final centerGua = LatLng(20.6737777, -103.4054538);
  final centerMxl = LatLng(32.6137391, -115.5203314);
  final centerMon = LatLng(25.8695013, -103.0146702);
  final centerSD = LatLng(32.8242404, -117.3891708);
  final centerTij = LatLng(32.49674, -117.0178474);
  final centerHunt = LatLng(33.5886801, -118.2697613);
  final centerSnJos = LatLng(37.2967792, -121.9574983);
  final centerMcAlln = LatLng(26.2259141, -98.396727);
  final centerCdJua = LatLng(31.6538179, -106.5890216);
  final centerHouTex = LatLng(29.8168824, -95.6814853);
  final centerBronwnsTex = LatLng(26.0288184, -97.5991826);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Boutiques ')),
        body: crearMapa(),
        floatingActionButton: botonesFlotantes(),
        bottomNavigationBar: _cardTipo1());
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
            geometry: centerBH,
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

  Widget _cardTipo1() {
    return Card(
        color: Colors.green,
        child: Container(
          width: double.infinity,
          height: 190,
          child: PageView(
            controller: PageController(viewportFraction: 0.5),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              _cardTipo2(),
              _cardTipo3(),
              _cardTipo4(),
              _cardTipo5(),
              _cardTipo6(),
              _cardTipo7(),
              _cardTipo8(),
              _cardTipo9(),
              _cardTipo10(),
              _cardTipo11(),
              _cardTipo12(),
              _cardTipo13(),
              _cardTipo14(),
              _cardTipo15(),
            ],
          ),
        ));
  }

  Widget _cardTipo2() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Beverly Hills'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerBH,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Beverly Hills',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo3() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Ciudad de México'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerCDMX,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Ciudad de México',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo4() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Culiacan'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerCul,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Culiacan',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo5() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique El Paso Texas'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerElPaTex,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'El Paso Texas',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo6() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Guadalajara'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerGua,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Guadalajara',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo7() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Mexicali'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerMxl,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Mexicali',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo8() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Monterrey'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerMon,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Monterrey',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo9() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique San Diego'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerSD,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'San Diego',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo10() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Tijuana'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerTij,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Tijuana',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo11() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Huntington'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerHunt,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Huntington',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo12() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique San José'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerSnJos,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'San José',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo13() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique McAllen'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerMcAlln,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'McAllen',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo14() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Ciudad Juarez'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerCdJua,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Ciudad Juarez',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo15() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Houston Texas'),
          subtitle: Text(
              'Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique, Aqui va la descripcion de la Boutique,'),
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                child: Text('Ver en el Mapa'),
                onPressed: () {
                  mapController.addSymbol(SymbolOptions(
                    geometry: centerHouTex,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Houston Texas',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }
}
