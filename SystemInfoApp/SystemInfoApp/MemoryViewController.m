//
//  MemoryViewController.m
//  SystemInfoApp
//
//  Created by Czer on 10/1/23.
//

#import "MemoryViewController.h"
#import "MemoryModel.h"


@interface MemoryViewController ()

@property (strong, nonatomic) NSTimer *memoryUsageTimer;

@end


@implementation MemoryViewController


// After the view has loaded this will run to set up and initialize the controller.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize a NSTimer object to call updateMemoryUsage
    self.memoryUsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMemoryUsage) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear {
    [super viewWillDisappear];
    
    // When the view is about to disappear invalidate the timer and set it to nil
    [self.memoryUsageTimer invalidate];
    self.memoryUsageTimer = nil;
}

- (void)updateMemoryUsage {
    // Calculate the overall Memory usage
    double memoryUsage = [MemoryModel overallMemoryPercent];
    
    // Update the NSTextField
    self.memoryUsageTextField.stringValue = [NSString stringWithFormat:@"%.02f%%", memoryUsage];
}

@end
