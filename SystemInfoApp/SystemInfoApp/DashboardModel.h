//
//  DashboardModel.h
//  SystemInfoApp
//
//  Created by Czer on 9/28/23.
//

#import <Foundation/Foundation.h>

@interface DashboardModel : NSObject

// Return the number of categories
- (NSInteger)numberOfCategories;

// Return the text for the nth category (zero-indexed)
- (NSString *)categoryTitleAtIdx:(NSInteger)Idx;

@end
