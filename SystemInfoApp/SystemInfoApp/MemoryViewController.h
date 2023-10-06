//
//  MemoryViewController.h
//  SystemInfoApp
//
//  Created by Czer on 10/1/23.
//

#import <Cocoa/Cocoa.h>

@interface MemoryViewController : NSViewController

// Display the percentage of used memory on the system
@property (weak) IBOutlet NSTextField *memoryUsageTextField;

@end
