# SystemInfoApp
An `Objective-C` app being developed in `Xcode` to help me learn how to interact with `macOS` system-level APIs. It will display real-time information about the system including CPU, disk, memory, and network usage.

## Software Details
### Main Dashboard
A vertical `Split View` is used to divide the left half of the main dashboard from the right. The left side contains a cell-based `Table View` that is connected to the `Main Dashboard Controller`. The Main Dashboard Controller adheres to the `NSTableViewDelegate` and `NSTableViewDataSource` protocols. `numberOfRowsInTableView` provides the number of rows in the table and `tableView:objectValueForTableColumn:row:` provides the string used in each table cell.

### CPU Monitor
The `CPUModel` provides a static function called `overallCPUPercent` as an interface to calculate the CPU usage across the system.

#### Calculating CPU Usage
`overallCPUPercent` uses the `Mach` library's `host_processor_info` function to get CPU tick information for each processor core. For each core the used ticks are added to a global total using `CPU_STATE_USER` and `CPU_STATE_SYSTEM` and the idle ticks are collected from `CPU_STATE_IDLE`. Once the values of these are summed from all cores, the overall CPU usage on the system can be calculated by:

Total CPU Usage Percent = ( `used ticks` / ( `used ticks` + `idle ticks` )) * 100

#### Displaying the CPU usage in the view
The `CPUViewController` uses `NSTimer` to call `overallCPUPercent` every few seconds. The exact amount will eventually be set by an app setting that can be changed by the user, but until that portion of the software is implemented it is just set to `1 second`.

### Memory Monitor
The `MemoryModel` provides a static function called `getMemoryUsage` as an interface to calculate the memory usage across the system. It returns a `MemoryInfo` struct with the following data:
```
struct MemoryInfo {
    double totalPhysicalMemoryGB;       // Total physical memory available in GB
    double totalMemoryUsedGB;           // Active + Wire memory used in GB
    double activeMemoryUsedGB;          // Active memory used in GB
    double wireMemoryUsedGB;            // Wired memory used in GB
    double totalMemoryUsedPercent;      // Percent of (active + wired) memory used over total physical
};
```

#### Calculating Memory Usage
`getMemoryUsage` uses the `Mach` library's `host_statistics64` function to get the number of `free_count`, `inactive_count`, `active_count`, and `wire_count` from virtual memory using the `vm_statistics64_data_t` struct.

Page counts are converted to GB using a conversion factor of: (`vm_page_size` * (`1 / 1073741824`)). 1073741824 is 2^30 which is the number of bytes in a GB.

- `totalPhysicalMemoryGB` is calculated by adding the `free`, `inactive`, `active`, and `wire` page counts, converted to GB.
- `totalMemoryUsedGB` is calculated by adding the `active` and `wire` page counts, converted to GB.
- `totalMemoryUsedPercent` is calculated by (`totalMemoryUsedGB` / `totalPhysicalMemoryGB`) * 100;
- `activeMemoryUsedGB` and `wireMemoryUsedGB` are reported directly from the outputs of `host_statistics64` after being converted to GB.


## Initial Software Requirements
This project was based on the following requirements

### Functional Requirements

#### Main Dashboard
The `Main Dashboard` needs to display a list of statistics `categories`
- CPU
- Memory
- Storage
- Network

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

# Development Environment
Due to the constraints of developing on a late 2012 iMac, some of my code may incorporate older practices or APIs. For clarity and transparency, I've outlined my development environment details below.

### Clang Compiler Version
```
Apple clang version 12.0.0 (clang-1200.0.32.29)
Target: x86_64-apple-darwin19.6.0
Thread model: posix
```

### Xcode version
```
Version 12.4 (12D4e)
```

### Operating System
```
OSX Catalina 10.15.7
```
