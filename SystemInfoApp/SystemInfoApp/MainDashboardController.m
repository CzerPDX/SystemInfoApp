//
//  MainDashboardController.m
//  SystemInfoApp
//
//  Created by Czer on 9/27/23.
//
//  Note, some comments contain links to apple documentation or quotes as a reminder for the future
//

#import "MainDashboardController.h"
#import "DashboardModel.h"


@interface MainDashboardController ()

// Declare an instance of the model
@property (strong, nonatomic) DashboardModel *dashboardModel;

@end


@implementation MainDashboardController

/*
 From Apple's documentation on Table View Delegates:
 
 Using a table view delegate allows you to customize a table view’s behavior without creating a table view subclass. A table view delegate provides views for table rows and columns, and supports functionality such as column reordering and resizing and row selection. To learn more about table views, see NSTableView.
 
 https://developer.apple.com/documentation/appkit/nstableviewdelegate?language=objc
 */

// After the view has loaded this will run to set up and initialize the controller.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the model after the view has loaded
    self.dashboardModel = [[DashboardModel alloc] init];
    [self.dashboardTableView setDelegate:self];
    [self.dashboardTableView setDataSource:self];
}

// Delegate method overrides for the dashboardTableView
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.dashboardModel numberOfCategories];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [self.dashboardModel categoryTitleAtIdx:row];
}

// Respond to a row being selected
// https://developer.apple.com/documentation/appkit/nstableviewdelegate/1528567-tableviewselectiondidchange?language=objc

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    // Determine which row is selected:
    NSInteger idx = self.dashboardTableView.selectedRow;
    NSString *rowTitle = [self.dashboardModel categoryTitleAtIdx:idx];
    NSLog(@"%@", rowTitle);
}

@end
