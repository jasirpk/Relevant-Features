
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:adjust_sdk/adjust.dart';
import 'package:adjust_sdk/adjust_config.dart';
import 'package:adjust_sdk/adjust_event.dart';
import 'package:adjust_sdk/adjust_attribution.dart';

class AdjustService {
  // Adjust App Token and Environment
  static const String adjustToken = '2dmq9ivpnji8'; 
  static const AdjustEnvironment environment = AdjustEnvironment.sandbox; // Use sandbox for testing; use production for live apps

  // Method to initialize Adjust SDK
  static void initializeAdjust() {
    // Create Adjust Config
    AdjustConfig config = AdjustConfig(adjustToken, environment);

    // Optional: Set the log level for debugging
    config.logLevel = AdjustLogLevel.verbose;

    // Optional: Set attribution callback
    config.attributionCallback = (AdjustAttribution attribution) {
      print('Attribution callback received');
      print('Network: ${attribution.network}');
      print('Campaign: ${attribution.campaign}');
      print('Adgroup: ${attribution.adgroup}');
      print('Creative: ${attribution.creative}');
    };

    // Initialize Adjust
    Adjust.initSdk(config); // Correct method for starting Adjust SDK

    print("Adjust SDK initialized.");
  }

  // Method to track events in Adjust
  static void trackEvent(String eventToken) {
    AdjustEvent event = AdjustEvent(eventToken);
    
    // Optional: Add revenue information if the event is related to revenue
    // event.setRevenue(0.99, 'USD'); // Example for revenue tracking

    // Optional: Add callback parameters
    event.addCallbackParameter('key', 'value');

    // Track the event with Adjust
    Adjust.trackEvent(event);
    print("Tracked event: $eventToken");
  }

  // Method to handle app coming to foreground
  static void onResume() {
    Adjust.onResume();
    print("App resumed, Adjust session started.");
  }

  // Method to handle app going to background
  static void onPause() {
    Adjust.onPause();
    print("App paused, Adjust session paused.");
  }
}
