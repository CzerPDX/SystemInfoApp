# SystemInfoApp
An `Objective-C` app being developed in `Xcode` to help me learn how to interact with `macOS` system-level APIs. It will display real-time information about the system including CPU, disk, memory, and network usage.


## Software Requirements

### Functional Requirements

#### Main Dashboard
The `Main Dashboard` needs to display a list of statistics `categories`
- CPU Usage
- Memory Usage
- Disk Usage
- Network Information.

#### Monitoring
When any of the above `categories` in the `Main Dashboard` is selected a new window should appear to display the real-time data for that `category`.

#### Settings Page
There will also be a `Settings` page. It will give users the abilty to:
- Choose a `light mode` or `dark mode (default)`.
- Change the `refresh rate` for the real-time statistics in the `Monitoring` section.

### Technical Requirements

#### Language and Framework
The application will be developed in `Objective-C` using `Xcode` as an IDE in a `MacOS` environment.

#### macOS System Calls
Uses the macOS system-level APIs to get data from the `categories` listed in the `Main Dashboard`:
- CPU
- Memory
- Disk
- Network

#### User Interface
The UI will be built visually using Xcode's `interface builder` and those visual elements will be interacted with using Cocoa's `AppKit`.

#### Data Binding
The application will use either `Cocoa Bindings` or manual-written code to keep the model and view synchronized in the `Monitor`. This will be evaluated once the project is underway a little bit.

#### User Settings
The application will use the macos `UserDefaults` API to save their preferences in the `Settings` menu.

#### Code Structure
The application will follow the [`MVC` design pattern](https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html).  It will have separate objects for:
- `Model` that holds and manages all the data for the application. It doesn't usually have any direct connection to the UI
- `View` that displays the data from the model to users and allows them to edit it. It shouldn't store any data
- `Controller` that acts as a switchboard between the `Model` and the `View`. It updates the `Model` based on user interactions captured by the `View` and refreshes the `View` based on changes in the `Model`.

#### Error Handling
The application will implement proper error handling for scenarios like failed system API calls.

#### Unit Tests
Write unit tests to cover important functions.

### Additional Features
If I get really industrious I'm going to implement some additional features iteratively after the core software is finished. 

#### Notifications
Implement macOS notifications to alert the user when certain thresholds are crossed (ie: CPU usage above 90%).

#### Help Page
Include a Help section within the app that provides guidance on how to use the features.
