import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';

class ChooseLocationPage2 extends StatefulWidget {
  const ChooseLocationPage2({Key? key}) : super(key: key);

  @override
  State<ChooseLocationPage2> createState() => _ChooseLocationPage2State();
}

class _ChooseLocationPage2State extends State<ChooseLocationPage2> {
  //get map controller to access map
  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  String _draggedAddress = "";
  PersistentBottomSheetController? _bottomSheetController;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    //set default latlng for camera position
    _defaultLatLng = const LatLng(11, 104);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition =
        CameraPosition(target: _defaultLatLng, zoom: 17.5 // number of map view
            );

    //map will redirect to my current location when loaded
    _gotoUserCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      //get a float button to click and go to current location
    );
  }

  Widget _buildBody() {
    return Stack(children: [
      _getMap(),
      _getCustomPin(),
      Align(
        alignment: Alignment.bottomCenter,
        child: _showDraggedAddress(),
      ),
      Positioned(
        top: 38,
        left: 15,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context, {null, null, null});
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 220, 220, 220), width: 1.5),
                  right: BorderSide(
                      color: Color.fromARGB(255, 220, 220, 220), width: 1.5),
                  left: BorderSide(
                      color: Color.fromARGB(255, 220, 220, 220), width: 1.5),
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 220, 220, 220), width: 1.5),
                )),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _showDraggedAddress() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(right: AppInfo.main_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _gotoUserCurrentPosition();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.my_location_rounded,
                        size: 30,
                        color: Color.fromARGB(255, 31, 109, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            //height: 170,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(20)),
              color: Color.fromARGB(255, 250, 250, 250),
              border: Border(
                top: BorderSide(
                    color: Color.fromARGB(255, 220, 220, 220), width: 1.5),
                right: BorderSide(
                    color: Color.fromARGB(255, 220, 220, 220), width: 1.5),
                left: BorderSide(
                    color: Color.fromARGB(255, 220, 220, 220), width: 1.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppInfo.main_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: Text(
                    _draggedAddress,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  )),
                  const SizedBox(height: 25),
                  Sizedbutton(
                    onPressFun: () {
                      List<String> parts = _draggedAddress.split(', ');
                      String detailedAddress = parts[0];

                      Navigator.pop(context,
                          "${detailedAddress}, ${_draggedLatlng.latitude} - ${_draggedLatlng.longitude}");
                    },
                    text: "Chọn vị trí này",
                    width: double.infinity,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getMap() {
    return GoogleMap(
      initialCameraPosition:
          _cameraPosition!, //initialize camera position for map
      mapType: MapType.terrain,
      onCameraIdle: () {
        //this function will trigger when user stop dragging on map
        //every time user drag and stop it will display address
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) {
        //this function will trigger when user keep dragging on map
        //every time user drag this will get value of latlng
        _draggedLatlng = cameraPosition.target;
      },
      onMapCreated: (GoogleMapController controller) {
        //this function will trigger when map is fully loaded
        if (!_googleMapController.isCompleted) {
          //set controller to google map when it is fully loaded
          _googleMapController.complete(controller);
        }
      },
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: Container(
        width: 90,
        child: Lottie.asset(
          "assets/images/pin.json",
        ),
      ),
    );
  }

  //get address from dragged pin
  Future _getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String addresStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    setState(() {
      _draggedAddress = addresStr;
    });
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  //go to specific position by latlng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
