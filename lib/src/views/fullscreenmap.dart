import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

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
    addImageFromUrl("assetImage", "assets/batman.png");
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
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () {
          mapController.addSymbol(SymbolOptions(
              geometry: centerBH,
              iconImage: 'assetImage',
              iconSize: 0.7,
              textField: 'Beverly Hills',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
              geometry: centerCDMX,
              iconImage: 'assetImage',
              iconSize: 0.7,
              textField: 'Ciudad de México',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
              geometry: centerCul,
              iconImage: 'assetImage',
              iconSize: 0.7,
              textField: 'Culiacán',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
            geometry: centerElPaTex,
            iconImage: 'assetImage',
            iconSize: 0.7,
            textField: 'El Paso Texas',
            textOffset: Offset(0, 2),
          ));
          mapController.addSymbol(SymbolOptions(
              geometry: centerGua,
              iconImage: 'assetImage',
              iconSize: 0.7,
              textField: 'Guadalajara',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
              geometry: centerMxl,
              iconImage: 'assetImage',
              iconSize: 0.7,
              textField: 'Mexicali',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
              geometry: centerMon,
              iconImage: 'assetImage',
              iconSize: 0.7,
              textField: 'Monterrey',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
            geometry: centerSD,
            iconImage: 'assetImage',
            iconSize: 0.7,
            textField: 'San Diego',
            textOffset: Offset(0, 2),
          ));
          mapController.addSymbol(SymbolOptions(
            geometry: centerTij,
            iconImage: 'assetImage',
            iconSize: 0.7,
            textField: 'Tijuana',
            textOffset: Offset(0, 2),
          ));
          mapController.addSymbol(SymbolOptions(
              geometry: centerHunt,
              iconImage: 'assetImage',
              iconSize: 0.7,
              textField: 'Huntington',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
              geometry: centerSnJos,
              iconImage: 'assetImage',
              iconSize: 0.7,
              textField: 'San José',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
              geometry: centerMcAlln,
              iconImage: 'assetImage',
              iconSize: 0.7,
              textField: 'McAllen',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
            geometry: centerCdJua,
            iconImage: 'assetImage',
            iconSize: 0.7,
            textField: 'Ciudad Juarez',
            textOffset: Offset(0, 2),
          ));
          mapController.addSymbol(SymbolOptions(
            geometry: centerHouTex,
            iconImage: 'assetImage',
            iconSize: 0.7,
            textField: 'Houston Texas',
            textOffset: Offset(0, 2),
          ));
        },
      ),
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
      MyStatefulWidget(),
      _cardTipo1(),
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
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Brownsville Texas'),
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
                    geometry: centerBronwnsTex,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Brownsville Texas',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        ),
        _cardTipo2(),
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Brownsville Texas'),
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
                    geometry: centerBronwnsTex,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Brownsville Texas',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }

  Widget _cardTipo2() {
    return Card(
        child: Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(Icons.photo_album, color: Colors.blue),
          title: Text('Boutique Brownsville Texas'),
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
                    geometry: centerBronwnsTex,
                    iconImage: 'assetImage',
                    iconSize: 0.7,
                    textField: 'Brownsville Texas',
                    textOffset: Offset(0, 2),
                  ));
                }),
          ],
        )
      ],
    ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String value = "";
  String dropdownValue = 'Tijuana';

  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.blue[900]),
      underline: Container(
        height: 2,
        color: Colors.blue[900],
      ),
      onChanged: (newValue) => {
        print(newValue.toString()),
        setState(() {
          dropdownValue = newValue;
        })
      },
      /*onChanged: (String newValue) {
        print(newValue.toString());
        setState(() {
          dropdownValue = newValue;
        });
      },*/
      items: <String>[
        'Beverly Hills',
        'Ciudad de México',
        'Culiacán',
        'El Paso Texas',
        'Guadalajara',
        'Mexicali',
        'Monterrey',
        'San Diego',
        'Tijuana',
        'Huntington',
        'San José',
        'McAllen',
        'Ciudad Juarez',
        'Houston Texas',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
