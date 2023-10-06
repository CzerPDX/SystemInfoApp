//
//  MemoryModel.m
//  SystemInfoApp
//
//  Created by Czer on 10/5/23.
//

#import "MemoryModel.h"
#import <mach/mach.h>


@interface MemoryModel ()

@end


@implementation MemoryModel

// Get the overall CPU usage on the system
+ (double)overallMemoryPercent {
    host_flavor_t flavor = HOST_VM_INFO64;
    vm_statistics64_data_t hostInfo;
    mach_msg_type_number_t hostInfoCount = HOST_VM_INFO64_COUNT;
    
    kern_return_t hostStatisticsResult = host_statistics64(mach_host_self(), flavor, (host_info64_t)&hostInfo, &hostInfoCount);
    
    if (hostStatisticsResult != KERN_SUCCESS) {
        NSLog(@"Error getting memory statistics. Error number: %d", hostStatisticsResult);
    } else {
        // Can get information about what's returned in vm_statistcis64_data_t from mach's vm_statistics.h
        
        // Number of pages of memory that are not being used and ready to be allocated to
        int64_t freePages = hostInfo.free_count;
        
        // Number of pages of memory that hold old data. They can be written to if needed but they hold onto the data in case it's needed again.
        int64_t inactivePages = hostInfo.inactive_count;
        
        // Number of pages of memory that are actively being used by applications, system processes, etc.
        int64_t activePages = hostInfo.active_count;
        
        // Number of pages that are 'wired' into place and can't be swapped out/paged to disk. Definitely not usable.
        int64_t wirePages = hostInfo.wire_count;
        
        // Free and inactive pages will be considered to be "available"
        // Active and wire pages will be considered "unavailable".
        int64_t totalPages = freePages + inactivePages + activePages + wirePages;
        int64_t totalBytes = totalPages * vm_page_size;
        NSLog(@"%.02f GB of memory on the system.", (double)totalBytes / 1000000000);
        
    }
    
    
    
    return 0.0;
}


@end
