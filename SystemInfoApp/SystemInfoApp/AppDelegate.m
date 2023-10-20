//
//  AppDelegate.m
//  SystemInfoApp
//
//  Created by Czer on 9/22/23.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
  // To avoid possible UI flicker, user defaults will be set here.
  
  // Setup object for user defaults
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  // Create a dictionary of defaults that are used to set up the default preferences for the program
  NSDictionary *defaultPreferences = @{
    @"WindowAppearancePreference": @("System Default"),
    @"LiveMonitorRefreshRateInSeconds": @(1)
  };
  
  // Then register these preferences as the default preferences
  [defaults registerDefaults:defaultPreferences];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
