//
//  CPUViewController.m
//  SystemInfoApp
//
//  Created by Czer on 10/1/23.
//


#import "CPUViewController.h"
#import "CPUModel.h"
#import "PreferencesModel.h"

// References
/*
 NSTimer information
 https://developer.apple.com/documentation/foundation/nstimer/1412416-scheduledtimerwithtimeinterval
 https://developer.apple.com/documentation/foundation/nstimer/1415405-invalidate
 */

@interface CPUViewController ()

// This is the timer that will refresh the CPU usage statistic
@property (strong, nonatomic) NSTimer *cpuUsageTimer;

@end


@implementation CPUViewController


// After the view has loaded this will run to set up and initialize the controller.
- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Give the CPU usage a value as soon as the window opens
  [self updateCPUUsage];
  // Then initialize a NSTimer object to call updateCPUUsage
  double intervalInSeconds = [PreferencesModel getRefreshRatePreference];
  self.cpuUsageTimer = [NSTimer scheduledTimerWithTimeInterval:intervalInSeconds target:self selector:@selector(updateCPUUsage) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear {
  [super viewWillDisappear];
  
  // When the view is about to disappear invalidate the timer and set it to nil
  [self.cpuUsageTimer invalidate];
  self.cpuUsageTimer = nil;
}

- (void)updateCPUUsage {
  // Calculate the overall CPU usage
  double cpuUsage = [CPUModel overallCPUPercent];
  
  // Update the NSTextField
  self.cpuUsageTextField.stringValue = [NSString stringWithFormat:@"%.02f%%", cpuUsage];
}


@end
