# IoT Sensor Viewer

A Flutter application that provides real-time monitoring and visualization of IoT sensor data through MQTT protocol. The application features a modern UI with real-time data updates and customizable alert notifications based on sensor thresholds.

## Features

- Real-time sensor data monitoring
- Customizable alert notifications
- Support for both analog and digital sensors
- Dark theme UI
- MQTT protocol integration
- Configurable alert conditions

## Project Structure

```
lib/
├── config/
│   └── themes/         # Application theming
├── core/
│   ├── network/        # Network related implementations
│   ├── services/       # Core services (notifications, etc.)
│   └── usecase/        # Business logic implementations
├── features/
│   └── show data/      # Sensor data display feature
├── injection_dependencies.dart  # Dependency injection setup
└── main.dart           # Application entry point
```

## MQTT Configuration

The application uses a public MQTT broker for demonstration purposes:
- Server: broker.emqx.io
- Port: 1883

## Message Format

The application expects sensor data in the following JSON format:

```json
{
  "sensors": [
    {
      "name": "string",
      "value": double,
      "alertValue": double,
      "alertCondition": "string",
      "isDigital": boolean
    }
  ]
}
```

### Alert Conditions

The following alert conditions are supported:
- `G` (>) - Greater than
- `GE` (>=) - Greater than or equal to
- `L` (<) - Less than
- `LE` (<=) - Less than or equal to
- `E` (==) - Equal to
- `NE` (!=) - Not equal to

### Example Message

```json
{
  "sensors": [
    {
      "name": "Humidity Sensor",
      "value": 70.5,
      "alertValue": 60.0,
      "alertCondition": "GE",
      "isDigital": false
    }
  ]
}
```

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

## Dependencies

- Flutter
- flutter_bloc (State management)
- MQTT client
- Notification services

## Architecture

The application follows a clean architecture pattern with:
- Feature-based organization
- Dependency injection
- BLoC pattern for state management
- Service-based core functionality

## Contributing

Feel free to submit issues and enhancement requests.




