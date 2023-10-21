//
//  PreferencesViewController.h
//  SystemInfoApp
//
//  Created by Czer on 10/20/23.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesViewController : NSViewController

// Outlets

// Window Appearance Switch
@property (weak) IBOutlet NSPopUpButton *windowAppearancePreference;

// Live monitoring refresh rate
@property (weak) IBOutlet NSTextField *refreshRatePreferenceTextField;


// Actions

// Update the window appearance preference
- (IBAction)windowAppearancePreferenceChanged:(NSPopUpButton *)sender;

// This will set the app's window preferences to whatever the default is
+ (void)updateWindowAppearanceToUserPreference;

@end
