import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';

class MyQibla extends StatefulWidget {
  const MyQibla({Key? key}) : super(key: key);

  @override
  _MyQiblaState createState() => _MyQiblaState();
}

class _MyQiblaState extends State<MyQibla> {
  bool _permissionStatus = false;

  @override
  void initState() {
    super.initState();
    _getPermissionStatus();
  }

  void _getPermissionStatus() {
    Permission.locationWhenInUse.status.then((statusVal) {
      if (mounted) {
        setState(() {
          _permissionStatus = statusVal == PermissionStatus.granted;
        });
      }
    });
  }

  Builder _sectionBuilder() {
    return Builder(builder: (context) {
      if (_permissionStatus) {
        return _compassSection();
      } else {
        return _noLocationAccessSection();
      }
    });
  }

  Container _compassSection() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

        ],
      ),
    );
  }

  Container _noLocationAccessSection() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Please allow the application to access location"),
          CupertinoButton(child: Text("Allow Location Usage"), onPressed: () {
            Permission.locationWhenInUse.request().then((statusVal) {
              _getPermissionStatus();
            });
          }),
          CupertinoButton(
              child: Text("Allow Permission Manually"), onPressed: () {
            openAppSettings().then((statusVal) => null);
          })
        ],
      ),
    );
  }

  StreamBuilder _compassBuilder() {
    return StreamBuilder<CompassEvent>(stream: FlutterCompass.events, builder: (context, snapshot) {
      double? _bearingVal = snapshot.data!.heading;

      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      if (snapshot.hasError) {
        return Text("Error encountered! ${snapshot.error}");
      }
      if (_bearingVal == null) {
        return Text("This device does not have the required sensor(s)");
      }

      return //TODO make the compass section
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Qibla Pointer"),
        ),
        body:
    );
  }
}

