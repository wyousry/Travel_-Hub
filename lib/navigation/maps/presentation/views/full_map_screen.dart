import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_hub/constant.dart';
import 'package:travel_hub/navigation/maps/presentation/widgets/map_controller.dart';


class FullMapScreen extends StatefulWidget {
  const FullMapScreen({super.key});

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {
  final FullMapController mapController = FullMapController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    mapController.setInitialLocation(() => setState(() {}));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          mapController.cameraPosition == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: mapController.cameraPosition!,
                  myLocationEnabled: true,
                  onMapCreated: (c) => mapController.googleController.complete(c),
                  markers: {
                    if (mapController.myMarker != null) mapController.myMarker!,
                    ...mapController.hotelMarkers,
                  },
                ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 15,
            right: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow:  [
                  BoxShadow(color:kBlack.withOpacity(0.2), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: TextField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: (val) => mapController.searchLocation(val.trim(), () => setState(() {})),
                decoration: InputDecoration(
                  hintText: "Search location...",
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => mapController.searchLocation(searchController.text.trim(), () => setState(() {})),
                  ),
                ),
              ),
            ),
          ),

   
          Positioned(
            bottom: 30,
            left: 20,
            child: FloatingActionButton(
              onPressed: () => mapController.goToMyLocation(() => setState(() {})),
              heroTag: "locationBtn",
              backgroundColor: linearGradient .colors.first,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
