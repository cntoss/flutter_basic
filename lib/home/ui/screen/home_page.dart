import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../../../common/app_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  Position? currentLocation;
  final Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<Position>? _positionStreamSubscription;
  //this source icon is for representing current location
  //BitmapDescriptor sourceIcon;
  Set<Marker> _markers = Set<Marker>();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getLocationDetail();
    //setSourceAndDestinationIcons();
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
    }
    super.dispose();
  }

  _getLocationDetail() async {
    currentLocation = await Geolocator.getCurrentPosition();
    if (currentLocation != null) {
      //updatePinOnMap();
      setState(() {
        _loading = false;
      });
    } else {
      Future.delayed(Duration.zero, () => _getLocationDetail());
    }
  }

  _getStreamPoint() {
    if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream(
          locationSettings:
              const LocationSettings(timeLimit: Duration(seconds: 30)));
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription!.cancel();
        _positionStreamSubscription = null;
      }).listen((position) {
        if (!mounted) return;
        setState(() {
          currentLocation = position;
        });
        updatePinOnMap();
      });
    }
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
    );
    print('Location updated');
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
  }

  /* void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.0), 'assets/location.png')
        .then((onValue) {
      sourceIcon = onValue;
    });
  } */

  @override
  Widget build(BuildContext context) {
    super.build(context);

    late CameraPosition _initialCameraPosition;
    var width = MediaQuery.of(context).size.width;
    if (!_loading && currentLocation != null) {
      _initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    /*  if (!_loading)
      _markers.add(Marker(
          markerId: MarkerId('current'),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          icon: sourceIcon));
 */
    TextStyle _incomeStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Online'),
        actions: [
          Switch(
            activeColor: Colors.redAccent,
            inactiveThumbColor: Colors.grey,
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.black12,
            value: true, //_isOnline,
            onChanged: (value) {},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _loading
              ? const Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white))
              : GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  tiltGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  scrollGesturesEnabled: true,
                  markers: _markers,
                  initialCameraPosition: _initialCameraPosition,
                  gestureRecognizers: Set()
                    ..add(Factory<EagerGestureRecognizer>(
                        () => EagerGestureRecognizer())),
                  onMapCreated: (GoogleMapController controller) {
                    //controller.setMapStyle(Utils.mapStyles);
                    _controller.complete(controller);
                    // my map has completed being created;
                    // i'm ready to show the pins on the map
                    // showPinsOnMap();
                  },
                ),
          /*  FutureBuilder(
            future: Geolocator.getCurrentPosition(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done)
                return showMap(snapshot.data);
              else
                return Center(child: Text('Error Occured'));
            }), */
          Positioned(
            bottom: 46,
            width: width,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(flex: 1),
                  Flexible(
                    flex: 10,
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Text('Income', style: _incomeStyle)),
                        Text(
                          'Rs 0',
                          style: _incomeStyle,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.black,
                    width: 1,
                  ),
                  Column(
                    children: [
                      Text('Trips', style: _incomeStyle),
                      Text('0', style: _incomeStyle)
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
