//
//  PreferencesViewController.m
//  SystemInfoApp
//
//  Created by Czer on 10/20/23.
//

#import "PreferencesViewController.h"

@interface PreferencesViewController ()

@end


@implementation PreferencesViewController

// After the view has loaded this will run to set up and initialize the controller.
- (void)viewDidLoad {
    [super viewDidLoad];
  
  // Get the window appearance setting from user preferences and set the dropdown to it
  NSString *windowAppearancePreferenceName = [[NSUserDefaults standardUserDefaults] objectForKey:@"WindowAppearancePreference"];
  [self.windowAppearancePreference selectItemWithTitle:windowAppearancePreferenceName];
}

// This function will run when the dark mode switch is changed from one to the other
- (IBAction)windowAppearancePreferenceChanged:(NSPopUpButton *)sender {
  
  NSLog(@"User changed dropdown for window appearance! Current state:	 %@", sender.selectedItem.title);
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

  // Set the window appearance preference to the value of the dropdown
  [defaults setObject:sender.selectedItem.title forKey:@"WindowAppearancePreference"];
  // Synchronize the defaults to disk
  [defaults synchronize];
}

@end
