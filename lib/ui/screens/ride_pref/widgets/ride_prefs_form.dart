import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../../widgets/actions/bla_button.dart';
import '../widgets/ride_prefs_input.dart';
import 'package:week_3_blabla_project/ui/widgets/inputs/bla_locaton_picker.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();

    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null; 
      departureDate = DateTime.now(); 
      arrival = null; 
      requestedSeats = 1; 
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void swapLocation() {
    setState(() {
      if (departure != null && arrival != null) {
        Location temp = departure!;
        departure = arrival;
        arrival = temp;
      }
    });
  }

  void onDeparturePressed() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (context) => LocationPicker(selectedLocation: departure),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (context) => LocationPicker(selectedLocation: arrival),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void pickDate() {
    showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          departureDate = selectedDate;
        });
      }
    });
  }
  
  void onSubmit() {

    if (departure == null || arrival == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both departure and arrival',
        style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    RidePref ridePref = RidePref(
      departure: departure!,
      arrival: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );

    Navigator.of(context).pop(ridePref);
  }


  
  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel => departure != null ? departure!.name : "From";
  String get arrivalLabel => arrival != null ? arrival!.name : "To";

  String get numberLabel => requestedSeats.toString();
  String get dateLabel => DateFormat('EEE dd MMM').format(departureDate);

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ 
          //  departure
          RidePrefInput(
            title: departureLabel,
            leftIcon: Icons.location_on,
            onPressed: onDeparturePressed,
            rightIcon: Icons.swap_vert_sharp,
            onRightIconPressed: swapLocation,
          ),
          const BlaDivider(),
  
          // arrival
          RidePrefInput(
            title: arrivalLabel,
            leftIcon: Icons.location_on,
            onPressed: onArrivalPressed,
          ),
          const BlaDivider(),
  
          // date
          RidePrefInput(
            title: dateLabel,
            leftIcon: Icons.calendar_month,
            onPressed: pickDate,
          ),
          const BlaDivider(),
  
          // number of seats
          RidePrefInput(
            leftIcon: Icons.person_2_outlined,
            title: numberLabel,
            onPressed: () {
              
            },
          ),



          const BlaDivider(),
          
          // Search button
          BlaButton (
            isPrimary: true,
            text: "Search",
            onPressed: onSubmit,
          ),
  
        ],
      );
  }
}
