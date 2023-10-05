//
//  CPUViewController.h
//  SystemInfoApp
//
//  Created by Czer on 10/1/23.
//

#import <Cocoa/Cocoa.h>

@interface CPUViewController : NSViewController

// Field to display the overall CPU usage of the system
@property (weak) IBOutlet NSTextField *cpuUsageTextField;

@end
