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
@property (weak) IBOutlet NSTextField *refreshRateTextField;


// Actions

// Update the dark mode switch
- (IBAction)windowAppearancePreferenceChanged:(NSPopUpButton *)sender;


@end
