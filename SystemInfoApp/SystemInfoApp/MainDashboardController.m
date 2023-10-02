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
#import "CPUViewController.h"
#import "MemoryViewController.h"
#import "StorageViewController.h"
#import "NetworkViewController.h"

typedef enum {
    kCircle,
    kRectangle,
    kOblateSpheroid
} RightPaneViewControllers;


@interface MainDashboardController ()

// Declare an instance of the model
@property (strong, nonatomic) DashboardModel *dashboardModel;

// Declare a reference to the view controller that will be in the right pane
@property (nonatomic, strong) NSViewController *currentRightPaneViewController;

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
    
    // Initialize CPUViewController from storyboard
    NSViewController *defaultViewController = [self.storyboard instantiateControllerWithIdentifier:@"CPUViewController"];
    
    // Add it as a child to this controller
    [self addChildViewController:defaultViewController];
    
    // Add view to rightPaneView
    [self.rightPaneView addSubview:defaultViewController.view];
    
    // Update the currentRightPaneViewController property to the
    self.currentRightPaneViewController = defaultViewController;
}

// Delegate method overrides for the dashboardTableView
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.dashboardModel numberOfCategories];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return [self.dashboardModel categoryTitleAtIdx:row];
}

// Respond to a row being selected to update view in right pane
// https://developer.apple.com/documentation/appkit/nstableviewdelegate/1528567-tableviewselectiondidchange?language=objc

- (void)switchPaneContentsByViewControllerID:(NSString *)viewControllerID {
    // Clear previous view controller and its view
    if (self.currentRightPaneViewController) {
        [self.currentRightPaneViewController.view removeFromSuperview];
        [self.currentRightPaneViewController removeFromParentViewController];
    }
    
    // Initialize CPUViewController from storyboard
    NSViewController *viewController = [self.storyboard instantiateControllerWithIdentifier:viewControllerID];
    
    // Add it as a child to this controller
    [self addChildViewController:viewController];
    
    // Add view to rightPaneView
    [self.rightPaneView addSubview:viewController.view positioned:NSWindowAbove relativeTo:self.rightPaneView];
    
    // Update the currentRightPaneViewController property
    self.currentRightPaneViewController = viewController;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    // Determine which row is selected:
    NSInteger idx = self.dashboardTableView.selectedRow;
    
    switch (idx) {
        case 0:
            [self switchPaneContentsByViewControllerID:@"CPUViewController"];
            break;
        case 1:
            [self switchPaneContentsByViewControllerID:@"MemoryViewController"];
            break;
        case 2:
            [self switchPaneContentsByViewControllerID:@"StorageViewController"];
            break;
        case 3:
            [self switchPaneContentsByViewControllerID:@"NetworkViewController"];
            break;
        default:
            NSLog(@"default!!");
    }
}

@end
