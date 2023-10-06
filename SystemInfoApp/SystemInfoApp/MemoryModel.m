//
//  MemoryModel.m
//  SystemInfoApp
//
//  Created by Czer on 10/5/23.
//

/*
 References:
 https://developer.apple.com/documentation/kernel/1502863-host_statistics64
 */

#import "MemoryModel.h"
#import <mach/mach.h>


@interface MemoryModel ()

@end


@implementation MemoryModel

// Convert from number of pages of memory into GB
+ (double)convertFromPagesToGB:(natural_t)memoryInPageCount {
    // A GB is 2^30 so the conversion needs to be the actual value of
    return memoryInPageCount * vm_page_size * (1 / 1073741824.0);
}

+ (MemoryInfo)getMemoryUsage {
    MemoryInfo memoryData = {0};
    
    // Get the total physical memory on the system via sysctl
    
    // Get the pages of app and wired memory via host_statistics
    host_flavor_t flavor = HOST_VM_INFO64;
    vm_statistics64_data_t hostInfo;
    mach_msg_type_number_t hostInfoCount = HOST_VM_INFO64_COUNT;
    kern_return_t hostStatisticsResult = host_statistics64(mach_host_self(), flavor, (host_info64_t)&hostInfo, &hostInfoCount);
    
    if (hostStatisticsResult != KERN_SUCCESS) {
        NSLog(@"Error getting memory statistics. Error number: %d", hostStatisticsResult);
    } else {
        
        memoryData.totalPhysicalMemoryGB = [MemoryModel convertFromPagesToGB:(hostInfo.active_count + hostInfo.inactive_count + hostInfo.free_count + hostInfo.wire_count)];
        memoryData.totalMemoryUsedGB = [MemoryModel convertFromPagesToGB:(hostInfo.active_count + hostInfo.wire_count)];
        memoryData.activeMemoryUsedGB = [MemoryModel convertFromPagesToGB:hostInfo.active_count];
        memoryData.wireMemoryUsedGB = [MemoryModel convertFromPagesToGB:hostInfo.wire_count];
        memoryData.totalMemoryUsedPercent = (memoryData.totalMemoryUsedGB / memoryData.totalPhysicalMemoryGB) * 100;
    }
    
    return memoryData;
}


@end
