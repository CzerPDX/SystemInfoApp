//
//  TextSubmitController.h
//  SystemInfoApp
//
//  Created by Czer on 9/27/23.
//

#import <Cocoa/Cocoa.h>

@interface TextSubmitController : NSViewController

// Field for taking in user input
@property (weak) IBOutlet NSTextField *textField;

// Field for displaying user input
@property (weak) IBOutlet NSTextField *displayText;

// Update model based on user input
- (IBAction)submitButtonClicked:(id)sender;

@end
