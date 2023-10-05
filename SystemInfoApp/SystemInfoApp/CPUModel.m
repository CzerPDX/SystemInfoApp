//
//  CPUModel.m
//  SystemInfoApp
//
//  Created by Czer on 10/3/23.
//

#import "CPUModel.h"
#import <mach/mach.h>




@interface CPUModel ()

@end


@implementation CPUModel

// Get the overall CPU usage on the system
+ (double)overallCPUPercent {
    double usedPercentAllCores = 0.0;
    
    // Declare out parameters to hold values after going through host_processor_info
    natural_t processorCount;
    processor_cpu_load_info_t processorInfo;
    mach_msg_type_number_t processorInfoCount;

    // Get the list of processors via mach's host_processor_info
    kern_return_t hostProcessorInfoResult = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &processorCount, (processor_info_array_t *)&processorInfo, &processorInfoCount);
    
    
    if (hostProcessorInfoResult == KERN_SUCCESS) {
        int usedTicksAllCores = 0;  // Total used ticks across all cores
        int idleTicksAllCores = 0;  // Total idle ticks across all cores
        
        // Add up used and idle ticks across all cores
        for (int i = 0; i < processorCount; ++i) {
            usedTicksAllCores += (processorInfo[i].cpu_ticks[CPU_STATE_USER] + processorInfo[i].cpu_ticks[CPU_STATE_SYSTEM]);
            idleTicksAllCores += processorInfo[i].cpu_ticks[CPU_STATE_IDLE];
        }
        
        // Now calculate the processor usage across all cores
        usedPercentAllCores = ((double)usedTicksAllCores / (idleTicksAllCores + usedTicksAllCores)) * 100;
        
    } else {
        NSLog(@"Failed to get processor info with error code: %d", hostProcessorInfoResult);
    }
    
    // Deallocate memory that was allocated during host_processor_info
    if (processorInfo) {
        kern_return_t deallocateResult = vm_deallocate(mach_task_self(), (vm_address_t)processorInfo, sizeof(processor_cpu_load_info_data_t) * processorCount);
        
        if (deallocateResult != KERN_SUCCESS) {
            NSLog(@"Error deallocating processorInfo data");
        }
    }
    
    return usedPercentAllCores;
}


/*
 Note:
 Journal-style comments are used liberally below this point to aid learning. These would not be left in for production-level code.
 
 References:
 Began by finding someone who wanted to do the same thing as me to get an idea of where they started
 https://stackoverflow.com/questions/6785069/get-cpu-percent-usage-on-macos
 
 Reading through the documentation for the libraries of the top answer's imports I found out about Mach which allows access to some info about the system resources
 https://developer.apple.com/documentation/kernel/mach
 https://blog.guillaume-gomez.fr/articles/2021-09-06+sysinfo%3A+how+to+extract+systems%27+information
 
 A project I found that taught me how to parse the data coming out of host_processor_info by using a processor_cpu_load_info_t datatype and casting it to processor_info_array_t in the call to host_processor_info so I can use mach's machine.h CPU_STATE definitions to understand what it is I get
 https://ladydebug.com/blog/codes/cpuusage_mac.htm
 
 Information about the different types of CPU tick information (is for linux but still mostly applies here, except info on nice which isn't used in macos)
 https://blog.appsignal.com/2018/03/06/understanding-cpu-statistics.html
 
 In the processor section for Mach there are some functions I would like to try looking at the return data for in the inspector to see if they have what I need to get the CPU usage as a % for the machine as a whole.
 */


//// This function is for looking at mach's processor info as a test. Left in as-is as it's helpful for learning but overalCPUUsagePercent contains the clean implementation of this function
//+ (void)machTestProcessorInfo {
//    // processor_info uses out parameters so they have to first be declared
//    // https://developer.apple.com/documentation/kernel/1409385-processor_info
//
//    // processor_t is the id of the processor i want to look at. each "processor" is actually a core so really i will want to do this for all of the cores in my machine which can vary based on your processor.
//
//    // To get info about the processors, first I will use host_processor_info
//    // https://developer.apple.com/documentation/kernel/1502854-host_processor_info
//
//    // host_processor_info prototype:
//    // kern_return_t host_processor_info(host_t host, processor_flavor_t flavor, natural_t *out_processor_count, processor_info_array_t *out_processor_info, mach_msg_type_number_t *out_processor_infoCnt);
//
//    // Getting the host self port
//    host_t host = mach_host_self();
//    processor_flavor_t flavor = PROCESSOR_CPU_LOAD_INFO;
//
//    // Declare out parameters
//    natural_t processorCount;
//    processor_cpu_load_info_t processorInfo;        // Even though host_processor_info requires a processor_info_array_t type, if I use a processor_cpu_load_info_t type and then cast it to a processor_info_array_t type in the function, then the data will be eaiser to parse afterward.
//    mach_msg_type_number_t processorInfoCount;
//
//    // Get the list of processors via mach's host_processor_info
//    kern_return_t hostProcessorInfoResult = host_processor_info(host, flavor, &processorCount, (processor_info_array_t *)&processorInfo, &processorInfoCount);
//
//
//    if (hostProcessorInfoResult == KERN_SUCCESS) {
//        int usedTicksAllCores = 0;  // Total used ticks across all cores
//        int idleTicksAllCores = 0;  // Total idle ticks across all cores
//        for (int i = 0; i < processorCount; ++i) {
//            // NSLog(@"Processor info at index %d: %d", i, processorInfo[i]);
//            // I got pretty stuck here looking at the raw output as a series of ints, as it didn't make sense to me what they represented. After looking around the internet for documentation (SCARCE!) and reading the mach headers that defined the different flavors (processor_info.h) I finally figured out that, based on the flavor I use, the data in out_processor_info will vary. Using PROCESSOR_CPU_LOAD_INFO would set it to be the CPU ticks per processor, but it was still hard to understand exactly what types of processes were being represented with what.
//            // I found a page here https://ladydebug.com/blog/codes/cpuusage_mac.htm where this dev declares the out parameter as a processor_cpu_load_info_t struct instead of a processor_info_array_t. This was key for me as I realized they did this in order to make the processInfo struct readable. It still needs to be cast as processor_info_array_t in the function call, but the types are compatible so I could then dereference it using the processor_cpu_load_info_t struct afterward. A clearer explanation is below:
//            /*
//             Information on how processor_cpu_load_info_t is being used somewhat interchangably with processor_info_array_t in the call to and output from host_processor_info:
//
//             1. I declare processorInfo as a processor_cpu_load_info_t datatype because I want to use the structure of it to dereference the data in it later.
//             2. I cast it as a processor_info_array_t in the function call because that is what the host_processor_info expects for that parameter. These types are compatible because they ultimately represent blocks of memory that hold the same kind of data.
//             3. Because it was declared as a processor_cpu_load_info_t datatype, I can now use that struct's structure to dereference the tick counts in a more human-readable way including using the indicies defined in machine.h (like CPU_STATE_SYSTEM)
//             */
//            NSLog(@"Processor %d", i);
//            NSLog(@"User ticks:     %d", processorInfo[i].cpu_ticks[CPU_STATE_USER]);       // ticks used by user space processes
//            NSLog(@"System ticks:   %d", processorInfo[i].cpu_ticks[CPU_STATE_SYSTEM]);     // ticks used by the kernel
//            NSLog(@"Idle ticks:     %d", processorInfo[i].cpu_ticks[CPU_STATE_IDLE]);       // ticks not being used
//            NSLog(@"Nice ticks:     %d", processorInfo[i].cpu_ticks[CPU_STATE_NICE]);       // Not relevant in macos, just including it because it's in the struct
//
//            // Calculate the usage for each core individually
//            // Calculate the used ticks by adding together the user and system process ticks
//            int usedTicks = processorInfo[i].cpu_ticks[CPU_STATE_USER] + processorInfo[i].cpu_ticks[CPU_STATE_SYSTEM];
//
//            // Calculate the total ticks available by adding the used ticks together with the idle ticks
//            int totalTicks = usedTicks + processorInfo[i].cpu_ticks[CPU_STATE_IDLE];
//
//            // Calculate the percentage of CPU usage for this core by dividing the used ticks by the total ticks available
//            double usedPercent = ((double)usedTicks / totalTicks) * 100;
//
//            NSLog(@"Processor %d Usage Percent: %.02f%%", i, usedPercent);
//            NSLog(@"");
//
//            // Add ticks to allCores data to calculate all cores
//            usedTicksAllCores += usedTicks;
//            idleTicksAllCores += processorInfo[i].cpu_ticks[CPU_STATE_IDLE];
//        }
//
//        // Now calculate the processor usage across all cores
//        double usedPercentAllCores = ((double)usedTicksAllCores / (idleTicksAllCores + usedTicksAllCores)) * 100;
//
//        NSLog(@"Use percentage across all processor %d cores: %.02f%%", processorCount, usedPercentAllCores);
//
//        // Deallocate the memory used to get this processor info (note on https://boredzo.org/cpuusage/ mentions this is necessary and this dev takes a similar approach that I have)
//        /* The prototype is: vm_deallocate(<#vm_map_t target_task#>, <#vm_address_t address#>, <#vm_size_t size#>)
//         The target_task is usually a reference to the area the memory is stored in. This should be the current running application which can be gotten using mach's mach_task_self() method. Then the address and size are provided to the vm_deallocate function so the memory can be deallocated properly.
//         */
//        kern_return_t deallocateResult = vm_deallocate(mach_task_self(), (vm_address_t)processorInfo, sizeof(processor_cpu_load_info_data_t) * processorCount);
//
//        if (deallocateResult != KERN_SUCCESS) {
//            NSLog(@"Error deallocating processorInfo data");
//        }
//    } else {
//        NSLog(@"Failed to get processor info with error code: %d", hostProcessorInfoResult);
//    }
//}



@end
