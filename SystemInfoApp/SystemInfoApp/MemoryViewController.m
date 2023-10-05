//
//  MemoryViewController.m
//  SystemInfoApp
//
//  Created by Czer on 10/1/23.
//

#import "MemoryViewController.h"
#import "MemoryModel.h"


@interface MemoryViewController ()

@end


@implementation MemoryViewController


// After the view has loaded this will run to set up and initialize the controller.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MemoryModel overallMemoryPercent];
}


@end
