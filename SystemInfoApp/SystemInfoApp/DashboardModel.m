//
//  DashboardModel.m
//  SystemInfoApp
//
//  Created by Czer on 9/28/23.
//

#import "DashboardModel.h"

@interface DashboardModel ()

@property (strong, nonatomic) NSArray *categoryTitles;
@end


@implementation DashboardModel

- (instancetype)init {
    self = [super init];
    // Initialize cateories for live monitoring
    if (self) {
        self.categoryTitles = @[@"CPU", @"Memory", @"Storage", @"Network"];
    }
    return self;
}

// Return the number of category titles
- (NSInteger)numberOfCategories {
    return [self.categoryTitles count];
}

// Return the category title at index
- (NSString *)categoryTitlesAtIdx:(NSInteger)idx {
    return [self.categoryTitles objectAtIndex:idx];
}

@end
