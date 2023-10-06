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

// Get the overall CPU usage on the system
+ (double)overallMemoryPercent {
    double overallMemoryPercent = 0.0;
    host_flavor_t flavor = HOST_VM_INFO64;
    vm_statistics64_data_t hostInfo;
    mach_msg_type_number_t hostInfoCount = HOST_VM_INFO64_COUNT;
    
    kern_return_t hostStatisticsResult = host_statistics64(mach_host_self(), flavor, (host_info64_t)&hostInfo, &hostInfoCount);
    
    if (hostStatisticsResult != KERN_SUCCESS) {
        NSLog(@"Error getting memory statistics. Error number: %d", hostStatisticsResult);
    } else {
        // Can get information about what's returned in vm_statistcis64_data_t from mach's vm_statistics.h
        
        // Breakdown of the types of virtual memory pages reported in the vm_statistics64_data_t struct
        // free_count:  Number of pages of memory that are not being used and ready to be allocated to
        // inactive_count:  Number of pages of memory that hold old data. They can be written to if needed but they hold onto the data in case it's needed again. Technically is "used" but is available to be overwritten so it will be counted as "available" memory for this application
        // active_count:  Number of pages of memory that are actively being used by applications, system processes, etc.
        // wire_count:  Number of pages that are 'wired' into place and can't be swapped out/paged to disk. Definitely not usable.
        
        // Free and inactive pages are be considered to be "available"
        // Active and wire pages are be considered "unavailable".
        int64_t unavailablePages = hostInfo.active_count + hostInfo.wire_count;
        int64_t totalPages = unavailablePages + hostInfo.inactive_count + hostInfo.free_count;
        
        // Calculate the percent of available memory
        overallMemoryPercent = ((double)unavailablePages / totalPages) * 100;
    }
    
    return overallMemoryPercent;
}


@end
