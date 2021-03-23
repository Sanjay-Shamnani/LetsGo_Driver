import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'my_account.dart';
import '../shared/loading.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  
  int _curentIndex = 0;
  final _screens = [
    MapScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Go Drive"),
        backgroundColor: Colors.black,
      ),
      body: _screens[_curentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            title: Text('Rides'),
            backgroundColor: Colors.black
          ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap:(index) {
          setState(() {
            _curentIndex = index;
          });
        },
      ),
    );
  }
}

class MapScreen extends StatefulWidget{
  @override
  _MapScreen createState() => _MapScreen();
}

class _MapScreen extends State<MapScreen> {

  GoogleMapController _controller;
  bool val = true;
  String status = 'ONLINE';
  static LatLng _initialposition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return _initialposition == null
    ? Container(
      alignment: Alignment.center,
      child: Center(
        child: Loading(),
      ),
    )
    : Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(target: _initialposition,
            zoom: 20.0
            ),
            mapType: MapType.normal,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 60,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text('BOOKINGS'),
                      Text('0')
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text('TOTAL'),
                      Text('₹0')
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                ),
                Switch(
                  value: val,
                  onChanged: (bool e) => changeStatus(e),
                  activeColor: Colors.black,
                ),
                Text(status)
              ],
            ),
          ),
        ],
      );
  }

  void changeStatus(bool e){
    setState(() {
      if(e){
        status = 'ONLINE';
        val = true;
        e = true;
      }
      else{
        status = 'OFFLINE';
        val = false;
        e = false;
      }
    });
  }
  
  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialposition = LatLng(position.latitude, position.longitude);
    });
  }

}