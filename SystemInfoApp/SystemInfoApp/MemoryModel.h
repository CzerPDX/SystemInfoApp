//
//  MemoryModel.h
//  SystemInfoApp
//
//  Created by Czer on 10/5/23.
//

#import <Foundation/Foundation.h>

struct MemoryInfo {
    double totalPhysicalMemoryGB;
    double totalMemoryUsedGB;
    double activeMemoryUsedGB;
    double wireMemoryUsedGB;
    double totalMemoryUsedPercent;
};

typedef struct MemoryInfo MemoryInfo;

@interface MemoryModel : NSObject


// Get Memory info
+ (MemoryInfo)getMemoryUsage;

@end
