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
}

// This function will run when the dark mode switch is changed from one to the other
- (IBAction)darkModeSwitchChanged:(NSSwitch *)darkModeSwitchSender {
  
  NSLog(@"dark mode switch activated! Current state %ld", darkModeSwitchSender.state);
  // Load the user defaults for the program
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  // Get the current value of the darkModeSwitchSender that the user set it to and set it as the default for the DarkModeEnabled preference
  [defaults setBool:(darkModeSwitchSender.state == NSControlStateValueOn) forKey:@"DarkModeEnabled"];
  
  // Then explicitly synchronize the defaults with the system settings for the program
  // I have read that this may happen automatically but to be sure I am calling it here explicitly to save the changes to disk
  [defaults synchronize];
}

@end
