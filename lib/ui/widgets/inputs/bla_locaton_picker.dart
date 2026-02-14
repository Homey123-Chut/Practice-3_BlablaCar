import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import '../../../model/ride/locations.dart';
import '../../../data/dummy_data.dart';

class LocationPicker extends StatefulWidget {
  final Location? selectedLocation;

  const LocationPicker({
    super.key,
    this.selectedLocation,
  });

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String currentSearchText = "";

  late TextEditingController searchController;
  late List<Location> filteredLocations;

   void onTap(Location location) {
    Navigator.pop<Location>(context, location);
  }

  void onBackTap() {
    Navigator.pop<Location>(context);
  }


  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();

    if (widget.selectedLocation != null) {
      searchController.text = widget.selectedLocation!.name;
    }

    filteredLocations = fakeLocations;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterLocations(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLocations = fakeLocations;
      } else {
        filteredLocations = [];
        for (var location in fakeLocations) {
          if (location.name.toLowerCase().contains(query.toLowerCase())) {
            filteredLocations.add(location);
          }
        }
      }
    });
  }

  void onSearchChanged(String search) {
    setState(() {
      currentSearchText = search;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Search field
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: filterLocations,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.chevron_left),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          filterLocations('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Locations list
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                final location = filteredLocations[index];

                return ListTile(
                  title: Text(location.name),
                  subtitle: Text(location.country.toString().split('.').last),
                  trailing: widget.selectedLocation == location
                      ? const Icon(Icons.check, color: Colors.blue)
                      : const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    Navigator.pop(context, location);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
