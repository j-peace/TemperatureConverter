# Temperature Converter

A native iOS application developed in SwiftUI that converts temperatures in real-time using weather data from your current location.

## Screenshots

### Main Interface (iPhone)
![Main Interface](screenshots/iphone-interface.png)

### Apple Watch
![Apple Watch Interface](screenshots/apple-watch-interface.png)

## Project Structure

```
TemperatureConversor/
├── TemperatureConversor/              # Main iOS app
│   ├── TemperatureConversorApp.swift  # App entry point
│   └── ContentView.swift              # Main interface
├── TemperatureConversorWatchApp/      # Apple Watch app
│   ├── TemperatureConversorWatchAppApp.swift
│   └── ContentView.swift
└── Shared/                            # Shared code
    ├── ContentViewModel.swift         # Business logic
    ├── WatchPreviewView.swift         # Apple Watch preview
    ├── WatchUnitSelectionView.swift   # Unit selection
    ├── LocationManager.swift          # Location management
    ├── Services/
    │   └── WeatherService.swift       # Weather data service
    ├── Models/
    │   └── WeatherModels.swift        # Data models
    └── Assets.xcassets/               # Visual assets
```

## How to Run

### Prerequisites

- Xcode 14.0 or higher
- iOS 15.0 or higher
- Apple Watch (optional, for testing the watchOS version)

### Installation

1. Clone the repository:
```bash
git clone git@github.com:j-peace/TemperatureConversor.git
cd TemperatureConversor
```

2. Open the project in Xcode:
```bash
open TemperatureConversor.xcodeproj
```

3. Select the target device (iPhone or Apple Watch)

4. Run the project (⌘+R)

## Configuration

### Required Permissions

The app requires the following permissions in `Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs your location to obtain accurate weather data.</string>
```

### APIs Used

- **Open-Meteo**: `https://api.open-meteo.com/v1/forecast`
- **Conversion API**: `https://api-crimson-river-7025.fly.dev`

## Data Flow

1. **Location**: App obtains user's GPS coordinates
2. **Weather Data**: Queries Open-Meteo API for current temperature
3. **Conversion**: Sends temperature in Celsius to conversion API
4. **Display**: Shows converted result in the interface

---

Backend Information ☁️
This project relies on a backend service for its data and operations. Here are the details:

Hosting Platform: The backend is currently hosted on Fly.dev.

API Endpoint: You can access the API at https://api-crimson-river-7025.fly.dev.

Description: The backend is a work-in-progress API built with Ruby. It handles temperature conversion logic and serves data to the mobile clients. The idea for this backend was born from a Ruby Learning challenge.

Backend Repository: The source code for the backend is hosted on SourceHut: https://git.sr.ht/~kells/temperature-conversion-api.

How to Contribute 🤝
Contributions are welcome for both the frontend and backend parts of the project!

Contributing to the Frontend (This Repository)
If you'd like to contribute to this iOS/watchOS application, please follow these steps:

Fork the repository.

Create a new branch for your feature or bug fix: git checkout -b feature/your-feature-name.

Make your changes and commit them with a descriptive message.

Push your branch to your forked repository: git push origin feature/your-feature-name.

Open a Pull Request and describe the changes you've made.

Contributing to the Backend (Ruby API)
The backend has a unique contribution process. Instead of using pull requests, it uses an email-based workflow with patches.

Repository: https://git.sr.ht/~kells/temperature-conversion-api

Contribution Workflow:

Clone the backend repository.

Make your changes and create a patch.

Contributions are submitted via git-send-email. All patches are sent to a public email list where they are discussed.

Setup & Guidelines: For detailed instructions on setting up your local environment, API documentation, and how to create and send patches, please refer to the documentation within the backend repository. The community there is happy to help you get started with the email-based workflow!
