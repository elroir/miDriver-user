import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points_plus/flutter_polyline_points_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/direction.dart';

final polylineProvider = StateNotifierProvider.autoDispose<PolylineNotifier,Polyline?>(
        (ref) => PolylineNotifier()
);


class PolylineNotifier extends StateNotifier<Polyline?>{


  PolylineNotifier() : super(null);

  void drawPolyline(Direction direction) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> points = polylinePoints.decodePolyline(direction.geometry).map((e) => LatLng(e.latitude, e.longitude)).toList();
    state = Polyline(
        points: points,
        strokeWidth: 4.0,
        color: Colors.black
    );

  }

}