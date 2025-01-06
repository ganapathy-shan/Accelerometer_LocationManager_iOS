Accelerometer and Location Manager App
======================================

Overview
--------

This app utilizes the iOS `CoreMotion` framework for accessing accelerometer data and the `CoreLocation` framework for monitoring the user's location in real-time. It displays the following information on the screen:

1.  **Distance Travelled**: Calculates the distance the user has moved in the last three minutes.
2.  **Real-time Device Movement Data**: Displays accelerometer data in real time.

This app is designed to help visualize movement patterns and user location in real time.

* * * * *

Features
--------

-   **Real-time Accelerometer Data**: Captures and updates device movement data on the screen.
-   **Location Tracking**: Continuously monitors the user's location and calculates the distance travelled.
-   **Real-time Updates**: Provides dynamic on-screen updates every few seconds.

* * * * *

Setup Instructions
------------------

### Prerequisites

-   macOS with Xcode installed (version 13 or later recommended).
-   iOS device (recommended for real-time accelerometer and GPS testing, as simulators do not support these features effectively).

### Steps to Run the App

1.  Clone or download the repository to your local machine.
2.  Open the `.xcodeproj` file in Xcode.
3.  Connect an iOS device to your Mac.
4.  Set up the app's signing and capabilities:
    -   Go to the **Signing & Capabilities** tab in Xcode.
    -   Add a development team.
5.  Build and run the app on your device by clicking the **Run** button in Xcode.
6.  Grant the app permissions for motion and location tracking when prompted.

* * * * *

How It Works
------------

### Accelerometer Integration

The app uses the `CoreMotion` framework to collect real-time accelerometer data. The data is processed to calculate and display:

-   **X, Y, Z-axis movement values**.
-   The overall motion trend.

### Location Manager

The `CoreLocation` framework enables location tracking and calculates:

-   The total distance travelled by the user within the last three minutes.
-   Continuous updates as the user moves.

### On-screen Display

The app presents all data visually, updating the UI in real-time for:

1.  Device motion data from the accelerometer.
2.  Distance metrics calculated from the GPS location.

* * * * *

Code Structure
--------------

-   **ViewController.swift**: Contains the logic for managing UI updates and integrating accelerometer and location data.
-   **LocationManager.swift**: Handles location updates and calculates the distance travelled.
-   **MotionManager.swift**: Manages accelerometer data collection using `CoreMotion`.

* * * * *

Permissions
-----------

This app requires the following permissions to function properly:

-   **Location Services**: To calculate the distance travelled.
-   **Motion & Fitness**: To capture real-time device movement data.

Make sure to enable these permissions in the app settings if they are not granted initially.

* * * * *

Notes
-----

-   Testing on a physical device is mandatory to access accelerometer and location data.
-   The distance calculation resets after three minutes for continuous tracking.
