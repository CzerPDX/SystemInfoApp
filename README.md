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
The `CPUViewController` uses `NSTimer` to call `overallCPUPercent` every few seconds based on the value returned by the `PreferencesModel`'s  `getRefreshRatePreference` method.

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

#### Displaying the memory usage in the view
The `MemoryViewController` uses `NSTimer` to call `updateMemoryUsage` every few seconds based on the value returned by the `PreferencesModel`'s  `getRefreshRatePreference` method.

### Preferences
The `PreferencesModel` interacts with the `NSUserDefaults` system API to save and update the following user preferences
- **Window Appearance:** Users can choose to have the application window in `Dark Mode`, `Light Mode`, or match whatever their `System Default` is.
- **Live Monitoring Refresh Rate** Users can change the refresh rate of the live monitoring pages with this setting,


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
