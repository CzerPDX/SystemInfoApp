//
//  Header.h
//  SystemInfoApp
//
//  Created by Czer on 9/27/23.
//

#import <Cocoa/Cocoa.h>

// MainDashboardController adheres to both NSTableViewDelegate and NSTableViewDataSource protocols
@interface MainDashboardController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

// dashboardTableView handles the list of statistics categories in left pane
@property (weak) IBOutlet NSTableView *dashboardTableView;

@end
