//
//  NetworkViewController.m
//  SystemInfoApp
//
//  Created by Czer on 10/1/23.
//

#import "NetworkViewController.h"


@interface NetworkViewController ()

@end


@implementation NetworkViewController


// After the view has loaded this will run to set up and initialize the controller.
- (void)viewDidLoad {
  [super viewDidLoad];
  [NetworkViewController testNetStatNSTask];
}

+ (void)testNetStatNSTask {
  // Create the task for netstat
  NSTask *task = [[NSTask alloc] init];
  [task setLaunchPath:@"/usr/sbin/netstat"];

  // Create a pipe to read the information back to the program
  NSPipe *pipe = [NSPipe pipe];
  [task setStandardOutput:pipe];

  // Try running the task
  NSError *error;
  [task launchAndReturnError:&error];
  // Should check error here
  
  NSFileHandle *fileHandleForReading = [pipe fileHandleForReading];
  
  NSData *dataFromFileHandle = [fileHandleForReading readDataToEndOfFileAndReturnError:&error];

}


@end
