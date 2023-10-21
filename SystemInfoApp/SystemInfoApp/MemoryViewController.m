//
//  MemoryViewController.m
//  SystemInfoApp
//
//  Created by Czer on 10/1/23.
//

#import "MemoryViewController.h"
#import "MemoryModel.h"
#import "PreferencesModel.h"


@interface MemoryViewController ()

@property (strong, nonatomic) NSTimer *memoryUsageTimer;

@end


@implementation MemoryViewController


// After the view has loaded this will run to set up and initialize the controller.
- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Give the Memory usage initial values as soon as the window opens
  [self updateMemoryUsage];
  // Then nitialize a NSTimer object to call updateMemoryUsage
  double intervalInSeconds = [PreferencesModel getRefreshRatePreference];
  self.memoryUsageTimer = [NSTimer scheduledTimerWithTimeInterval:intervalInSeconds target:self selector:@selector(updateMemoryUsage) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear {
  [super viewWillDisappear];
  
  // When the view is about to disappear invalidate the timer and set it to nil
  [self.memoryUsageTimer invalidate];
  self.memoryUsageTimer = nil;
}

- (void)updateMemoryUsage {
  // Calculate the overall Memory usage
  MemoryInfo memoryUsage = [MemoryModel getMemoryUsage];
  
  // Update the text fields on in the memory view
  self.totalPhysicalMemoryTextField.stringValue = [NSString stringWithFormat:@"%.02f", memoryUsage.totalPhysicalMemoryGB];
  
  self.totalMemoryUsedTextField.stringValue = [NSString stringWithFormat:@"%.02f", memoryUsage.totalMemoryUsedGB];
  
  self.activeMemoryUsedTextField.stringValue = [NSString stringWithFormat:@"%.02f", memoryUsage.activeMemoryUsedGB];
  
  self.wiredMemoryUsedTextField.stringValue = [NSString stringWithFormat:@"%.02f", memoryUsage.wireMemoryUsedGB];
  
  self.memoryUsagePercentTextField.stringValue = [NSString stringWithFormat:@"%.02f", memoryUsage.totalMemoryUsedPercent];
}

@end
