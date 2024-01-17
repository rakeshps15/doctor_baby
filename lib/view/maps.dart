import 'dart:async';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng initialLocation = const LatLng(37.422131, -122.084801);
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  Location locationController = Location();
  Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  CarouselController carouselController = CarouselController();

  List<Map<String, dynamic>> _dummyHospitals = [
    {
      "name": "Ernakulam Medical Center",
      "address": "123 Hospital Street, Ernakulam",
      "latitude": 10.0229,
      "longitude": 76.3075,
      "phone": "+91 93 456 7890"
    },
    {
      "name": "City General Hospital",
      "address": "456 Health Avenue, Ernakulam",
      "latitude": 10.0115,
      "longitude": 76.3052,
      "phone": "+91 97 654 3210"
    },
    {
      "name": "Sunrise Hospital",
      "address": "789 Care Boulevard, Ernakulam",
      "latitude": 10.0183,
      "longitude": 76.3038,
      "phone": "+91 97 890 1234"
    },
    {
      "name": "Greenfield Medical Center",
      "address": "234 Wellness Street, Ernakulam",
      "latitude": 10.0267,
      "longitude": 76.3097,
      "phone": "+91 75 678 9012"
    },
    {
      "name": "Royal Hospital",
      "address": "567 Health Lane, Ernakulam",
      "latitude": 10.0142,
      "longitude": 76.3105,
      "phone": "+91 79 012 3456"
    },
    {
      "name": "Unity Care Hospital",
      "address": "890 Healing Road, Ernakulam",
      "latitude": 10.0291,
      "longitude": 76.3043,
      "phone": "+91 91 234 5678"
    },
    {
      "name": "Civic Hospital",
      "address": "345 Medical Drive, Ernakulam",
      "latitude": 10.0248,
      "longitude": 76.3132,
      "phone": "+91 932 765 0987"
    },
    {
      "name": "Hope Medical Center",
      "address": "678 Lifeline Street, Ernakulam",
      "latitude": 10.0174,
      "longitude": 76.3157,
      "phone": "+91 91092991090"
    },
    {
      "name": "Evergreen Hospital",
      "address": "901 Health Square, Ernakulam",
      "latitude": 10.0305,
      "longitude": 76.3086,
      "phone": "+91 95 678 9012"
    },
    {
      "name": "Serene Medical Center",
      "address": "432 Harmony Avenue, Ernakulam",
      "latitude": 10.0137,
      "longitude": 76.2989,
      "phone": "+91 876 543 2109"
    },
    {
      "name": "Mission hospital",
      "address": "Near tcr",
      "latitude": 10.0137,
      "longitude": 76.2989,
      "phone": "+90909009090"
    },
  ];

  @override
  void initState() {
    super.initState();
    initMap();
  }

  Future<void> initMap() async {
    await addCustomIcon();
    await getLocationUpdates();
  }

  Future<void> addCustomIcon() async {
    final ByteData data =
        await rootBundle.load("assets/google.jpg");
    final Uint8List bytes = data.buffer.asUint8List();

    int width = 50;
    int height = 50;

    final Uint8List resizedBytes = await _resizeImage(bytes, width, height);

    final BitmapDescriptor customIcon =
        BitmapDescriptor.fromBytes(resizedBytes);

    setState(() {
      markerIcon = customIcon;
    });
  }

  Future<Uint8List> _resizeImage(Uint8List bytes, int width, int height) async {
    return FlutterImageCompress.compressWithList(
      bytes,
      minWidth: width,
      minHeight: height,
      quality: 85,
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus _permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationController.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
      }
    });
  }

  

  LatLng? _currentP;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          CircleAvatar(),
        ],
        leading: const Icon(Icons.menu),
        backgroundColor: Colors.white,
        title: Image.asset('assets/google.jpg', height: 60,),
        centerTitle: true,
      ),
      body: _currentP == null
          ? const Center(
              child: Text('Loading..'),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController mapcontroller) {
                    _mapController.complete(mapcontroller);
                  },
                  zoomControlsEnabled: false,
                  initialCameraPosition:
                      CameraPosition(target: _currentP!, zoom: 14),
                  markers: {
                    Marker(
                      markerId: const MarkerId('currentLocation'),
                      position: _currentP!,
                    ),
                    // Add markers for hospitals
                    for (var hospital in _dummyHospitals)
                      Marker(
                        markerId: MarkerId(hospital["name"]),
                        position:
                            LatLng(hospital["latitude"], hospital["longitude"]),
                        infoWindow: InfoWindow(
                          title: hospital["name"],
                          snippet: hospital["address"],
                        ),
                      ),
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       isDense: true,
                      //       fillColor: Colors.grey.shade300,
                      //       filled: true,
                      //       hintText: 'search',
                      //       suffixIcon: const Icon(
                      //         Icons.search,
                      //         color: Colors.blue,
                      //       ),
                      //       hintStyle: const TextStyle(
                      //         fontSize: 18,
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      CarouselSlider.builder(
                        carouselController: carouselController,
                        itemCount: _dummyHospitals.length,
                        itemBuilder: (context, index, value) {
                          Map<String, dynamic> hospital =
                              _dummyHospitals[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: 300,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade300,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hospital['name'],
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    hospital['phone'],
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    hospital['address'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  // Container(
                                  //   width: double.infinity,
                                  //   height: 50,
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //       color: Colors.blue,
                                  //       width: 3,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(20),
                                  //   ),
                                  //   child: const Center(
                                  //     child: Text(
                                  //       'View details',
                                  //       style: TextStyle(
                                  //         color: Colors.blue,
                                  //         fontWeight: FontWeight.w700,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            _updateMapLocation(
                                _dummyHospitals[index]["latitude"],
                                _dummyHospitals[index]["longitude"]);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  void _updateMapLocation(double latitude, double longitude) {
    if (_mapController.isCompleted) {
      _mapController.future.then((controller) {
        controller.animateCamera(
          CameraUpdate.newLatLng(LatLng(latitude, longitude)),
        
        );
      });
    }
  }
}