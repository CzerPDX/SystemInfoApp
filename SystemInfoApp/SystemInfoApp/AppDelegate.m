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
  // Putting appearance preference response in here to avoid UI flicker
  // Setup object for user defaults
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  // Create a dictionary of defaults that are used to set up the default preferences for the program
  NSDictionary *defaultPreferences = @{
    @"WindowAppearancePreference": @("System Default"),
    @"LiveMonitorRefreshRateInSeconds": @(1)
  };
  // Then register these preferences as the default preferences
  [defaults registerDefaults:defaultPreferences];
  
  
  // Now set the window appearance based on the user's preferences
  NSAppearance *appearance;
  NSString *userPreferredAppearanceName = [[NSUserDefaults standardUserDefaults] objectForKey:@"WindowAppearancePreference"];
  if ([userPreferredAppearanceName isEqualToString:@"Dark"]) {
    appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
  } else if ([userPreferredAppearanceName isEqualToString:@"Light"]) {
    appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
  } else if ([userPreferredAppearanceName isEqualToString:@"System Default"]) {
    appearance = nil;
  }
  [NSApp setAppearance:appearance];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
