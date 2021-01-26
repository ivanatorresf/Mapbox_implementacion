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
  final center = LatLng(18.918749, -104.073781);
  final center1 = LatLng(20.4323493, -87.01434);
  final center2 = LatLng(32.5265012, -117.120376);
  final center3 = LatLng(19.1788445, -96.2113358);

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
        body: crearMapa(), floatingActionButton: botonesFlotantes());
  }

  Column botonesFlotantes() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      FloatingActionButton(
        child: Icon(Icons.zoom_out),
        onPressed: () {
          mapController.addSymbol(SymbolOptions(
              geometry: center,
              // iconSize: 3,
              iconImage: 'assetImage',
              textField: 'La Ola Verde',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
              geometry: center1,
              // iconSize: 3,
              iconImage: 'assetImage',
              textField: 'Tecoman',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
              geometry: center2,
              // iconSize: 3,
              iconImage: 'assetImage',
              textField: 'El Diezmo',
              textOffset: Offset(0, 2)));
          mapController.addSymbol(SymbolOptions(
              geometry: center3,
              // iconSize: 3,
              iconImage: 'assetImage',
              textField: 'La Ola Verde2',
              textOffset: Offset(0, 2)));
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
    ]);
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: center, zoom: 6),
    );
  }
}
