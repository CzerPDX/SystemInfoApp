//
//  MainDashboardController.m
//  SystemInfoApp
//
//  Created by Czer on 9/27/23.
//

#import "MainDashboardController.h"
#import "DashboardModel.h"


@interface MainDashboardController ()

// Declare an instance of the model
@property (strong, nonatomic) DashboardModel *dashboardModel;

@end


@implementation MainDashboardController

// After the view has loaded that this is the controller for, this will run
- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the model after the view has loaded
    self.dashboardModel = [[DashboardModel alloc] init];
    [self.dashboardTableView setDelegate:self];
    [self.dashboardTableView setDataSource:self];
}

// Methods that tell the table how many rows to display and what data to show in each
// https://developer.apple.com/documentation/appkit/nstableviewdatasource?language=objc


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.dashboardModel numberOfCategories];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [self.dashboardModel categoryTitlesAtIdx:row];
}

@end

