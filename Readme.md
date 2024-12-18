# HealthTracker Water Intake App

## Overview
HealthTracker - The Water Intake App is an iOS application designed to help users track and maintain their daily water consumption. The app is built entirely in Swift.

## Features
- Track daily water intake.
- Shows the total amount of water intaken on the current day.
- View hydration progress through a water level animation.
- Add the amount of water intaken on current or previous day.
- Filter the amount of water intaken during the specific times of the day like Morning , Afternoon, Evening and Night
- Sort the water intaken to see when was the highest and lowest amount of water consumed.
- App supports both Dark and Light Mode.

## Prerequisites
Ensure you have the following installed on your development environment:
- **Xcode**: Version 13.0 or later.
- **iOS Deployment Target**: iOS 14.0 or later.
- **CocoaPods**: Ensure CocoaPods is installed for managing dependencies.

## Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/minnyjoseph03/healthtracker.git
    cd HealthTracker
    ```
2. Install dependencies using CocoaPods:
    ```bash
    pod install
    ```
3. Open the `.xcworkspace` file in Xcode:
    ```bash
    open WaterIntakeApp.xcworkspace
    ```
4. Build and run the app on a simulator or physical device.

## Technical Background
This app uses the following Pod files:
1. **Toast-Swift**: Toast-Swift is a Swift extension that adds toast notifications to the UIView object class. It is intended to be simple, lightweight, and easy to use. Most toast notifications can be triggered with a single line of code. (https://github.com/scalessec/Toast-Swift)


## Usage
1. The flash screen appears first.
2. App takes you to the Home Screen.
3. The water flow animation shows the total amount of water consumed on the current day.
4. Use Add button to add new enteries.
5. New Values may be entered for current and previous days.

