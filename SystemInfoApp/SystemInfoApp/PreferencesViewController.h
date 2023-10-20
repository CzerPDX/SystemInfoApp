//
//  PreferencesViewController.h
//  SystemInfoApp
//
//  Created by Czer on 10/20/23.
//

#import <Cocoa/Cocoa.h>

@interface PreferencesViewController : NSViewController

// Outlets

// Dark mode switch
@property (weak) IBOutlet NSSwitch *darkModeSwitch;

// Live monitoring refresh rate
@property (weak) IBOutlet NSTextField *refreshRateTextField;


// Actions

// Update the dark mode switch
- (IBAction)darkModeSwitchChanged:(NSSwitch *)darkModeSwitchSender;


@end
