//
//  PreferencesViewController.m
//  SystemInfoApp
//
//  Created by Czer on 10/20/23.
//

#import "PreferencesViewController.h"
#import "PreferencesModel.h"

@interface PreferencesViewController ()

@end


@implementation PreferencesViewController

// After the view has loaded this will run to set up and initialize the controller.
- (void)viewDidLoad {
    [super viewDidLoad];
  
  // Get the window appearance setting from user preferences and set the dropdown to it so it shows the current setting.
  NSString *windowAppearancePreferenceName = [PreferencesModel getWindowAppearancePreferenceName];
  [self.windowAppearancePreference selectItemWithTitle:windowAppearancePreferenceName];
}

// This function will run when the window appearance preference dropdown is changed.
- (IBAction)windowAppearancePreferenceChanged:(NSPopUpButton *)sender {
  // Update the user default setting for window appearance
  [PreferencesModel changeWindowAppearancePreference:sender.selectedItem.title];
  
  // Then change the application's apperance based on the current window appearance preference
  [PreferencesViewController updateWindowAppearanceToUserPreference];
}

// Update the window appearance of the app based on whatever is the current preference
+ (void)updateWindowAppearanceToUserPreference {
  
  // Create an appearance pointer to set based on the default apperance value
  NSAppearance *appearance;
  // Get the default window appearance name
  NSString *currentWindowApperanceName = [PreferencesModel getWindowAppearancePreferenceName];
  if ([currentWindowApperanceName isEqualToString:@"Dark"]) {
    appearance = [NSAppearance appearanceNamed:NSAppearanceNameDarkAqua];
  } else if ([currentWindowApperanceName isEqualToString:@"Light"]) {
    appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
  } else {
    appearance = nil;
  }
  // Update the appearance
  [NSApp setAppearance:appearance];
}

@end
