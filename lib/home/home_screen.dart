import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var myMarkers = HashSet<Marker>();
  late BitmapDescriptor customMarker;
  List<Polyline> myPolyline =[];

  getCustomMarker()async
  {
    customMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/images/1.jpg');
  }

  @override
  void initState()
  {
    super.initState();
    getCustomMarker();
    CreatePolyLine();
  }

  CreatePolyLine ()
  {
    myPolyline.add(Polyline(polylineId: const PolylineId('1'),
        color: Colors.blue,
        width: 3,
        points: const [LatLng(29.988194, 31.149488),
                       LatLng(30.015586, 31.212055),
                      ],
        patterns:
        [
          PatternItem.dash(20),
          PatternItem.gap(10),
        ]),
    );
  }

  Set<Polygon> myPolygon() {
    List<LatLng>polygonCoords =[];
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08832357078792));
    polygonCoords.add(const LatLng(37.43006265331129, -122.08332357078792));
    polygonCoords.add(const LatLng(37.43296265331129, -122.08832357078792));

    var polygonSet = Set<Polygon>();
    polygonSet.add(Polygon(
        polygonId: PolygonId('1'),
        points: polygonCoords,
        strokeColor: Colors.blue,
      ),
    );
    return polygonSet;
  }

  Set<Circle> myCircles = Set.from([Circle(
    circleId: CircleId('1'),
    center: LatLng(29.977600, 31.132279),
    radius: 10000,
    strokeWidth: 1,
  )]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
                target: LatLng(30.033333,	31.233334),
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController googleMapController)
            {
              setState(() {
                myMarkers.add(
                  Marker(
                      markerId: const MarkerId('1'),
                      position: const LatLng(29.977600, 31.132279),
                      infoWindow: const InfoWindow(
                      title: 'My Home',
                      snippet: 'Description', // icon: customMarker,
                    ),
                    onTap: ()
                    {
                      print('Accurate Location');
                    },
                 //   icon: customMarker,
                  ),
                );
              });
            },
            markers: myMarkers,
            polygons: myPolygon(),
          //  circles: myCircles,
            polylines: myPolyline.toSet(),
          ),
          const Text('Google Map',
            style:TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
