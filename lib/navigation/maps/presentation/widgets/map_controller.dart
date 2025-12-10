import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_hub/navigation/maps/services/hotel_service.dart';
import 'package:travel_hub/navigation/maps/services/location_service.dart';
import 'package:travel_hub/core/utils/assets.dart';

class FullMapController {
  final Completer<GoogleMapController> googleController = Completer();

  CameraPosition? cameraPosition;
  Marker? myMarker;
  Set<Marker> hotelMarkers = {};

  Future<void> setInitialLocation(Function refreshUI) async {
    Position pos = await LocationService.determinePosition();

    cameraPosition = CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 15,
    );

    myMarker = Marker(
      markerId: const MarkerId("me"),
      position: LatLng(pos.latitude, pos.longitude),
      infoWindow: const InfoWindow(title: "My Location"),
    );

    await _loadHotelMarkers(refreshUI);

    refreshUI();
  }

  Future<void> _loadHotelMarkers(Function refreshUI) async {
    List<Hotel> hotels = await HotelService.loadHotelsFromAsset();
    Set<Marker> markers = {};

    for (var hotel in hotels) {
      final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(5, 5)),
        AssetsData.hotelLogo,
      );

      markers.add(
        Marker(
          markerId: MarkerId(hotel.name),
          position: LatLng(hotel.latitude, hotel.longitude),
          icon: icon,
          infoWindow: InfoWindow(
            title: hotel.name,
            snippet: "Rating: ${hotel.rating}",
          ),
        ),
      );
    }

    hotelMarkers = markers;
    refreshUI();
  }

  Future<void> goToMyLocation(Function refreshUI) async {
    Position pos = await LocationService.determinePosition();
    final controller = await googleController.future;

    controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(pos.latitude, pos.longitude), 16),
    );
  }

  Future<LatLng?> searchLocation(String query) async {
    if (query.isEmpty) return null;

    try {
      final locations = await locationFromAddress(query);
      if (locations.isEmpty) return null;

      final loc = locations.first;
      return LatLng(loc.latitude, loc.longitude);
    } catch (e) {
      print("Search error: $e");
      return null;
    }
  }
}
