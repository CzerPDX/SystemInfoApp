//
//  CPUModel.m
//  SystemInfoApp
//
//  Created by Czer on 10/3/23.
//

#import "CPUModel.h"
#import <mach/mach.h>
#import <mach/host_priv.h>


/*
 Note:
 Journal-style comments are used liberally here to aid learning. These would not be left in for production-level code.
 
 References:
 Began by finding someone who wanted to do the same thing as me to get an idea of where they started
 https://stackoverflow.com/questions/6785069/get-cpu-percent-usage-on-macos
 
 Reading through the documentation for the libraries of the top answer's imports I found out about Mach which allows access to some ifno about the system resources
 https://developer.apple.com/documentation/kernel/mach
 
 In the processor section for Mach there are some functions I would like to try looking at the return data for in the inspector to see if they have what I need to get the CPU usage as a % for the machine as a whole.
 */

@interface CPUModel ()

@end


@implementation CPUModel

// This function is for looking at mach's processor info as a test
+ (void)machTestProcessorInfo {
    // processor_info uses out parameters so they have to first be declared
    // https://developer.apple.com/documentation/kernel/1409385-processor_info
    
    // processor_t is the id of the processor i want to look at. each "processor" is actually a core so really i will want to do this for all of the cores in my machine which can vary based on your processor.
    
    // To get info about the processors, first I will use host_processor_info
    // https://developer.apple.com/documentation/kernel/1502854-host_processor_info
    
    // host_processors prototype:
    // kern_return_t host_processor_info(host_t host, processor_flavor_t flavor, natural_t *out_processor_count, processor_info_array_t *out_processor_info, mach_msg_type_number_t *out_processor_infoCnt);
    
    // Getting the host self port
    host_t host = mach_host_self();
    processor_flavor_t flavor = PROCESSOR_CPU_LOAD_INFO;

    // Declare out parameters
    natural_t processorCount;
    processor_info_array_t processorInfo;
    mach_msg_type_number_t processorInfoCount;

    // Get the list of processors via mach's host_processor_info
    kern_return_t hostProcessorsResult = host_processor_info(host, flavor, &processorCount, &processorInfo, &processorInfoCount);
    
    if (hostProcessorsResult == KERN_SUCCESS) {
        NSLog(@"Number of processors: %d", processorCount);
    } else {
        NSLog(@"Failed to get processor info with error code: %d", hostProcessorsResult);
    }
}

@end
