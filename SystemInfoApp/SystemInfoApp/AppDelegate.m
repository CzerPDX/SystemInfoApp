//
//  AppDelegate.m
//  SystemInfoApp
//
//  Created by Czer on 9/22/23.
//

#import "AppDelegate.h"
#import "PreferencesViewController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)notification {
  // Putting appearance preference response in here to avoid UI flicker
  
  // Update the app's window color based on the user defaults
  [PreferencesViewController updateWindowAppearanceToUserPreference];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
