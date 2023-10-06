//
//  MemoryViewController.h
//  SystemInfoApp
//
//  Created by Czer on 10/1/23.
//

#import <Cocoa/Cocoa.h>

@interface MemoryViewController : NSViewController

// Total physical memory text field
@property (weak) IBOutlet NSTextField *totalPhysicalMemoryTextField;

// Total memory used text field
@property (weak) IBOutlet NSTextField *totalMemoryUsedTextField;

// App memory used text field
@property (weak) IBOutlet NSTextField *activeMemoryUsedTextField;

// Wired memory used text field
@property (weak) IBOutlet NSTextField *wiredMemoryUsedTextField;

// Total percentage used memory text field
@property (weak) IBOutlet NSTextField *memoryUsagePercentTextField;

@end
