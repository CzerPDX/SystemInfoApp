//
//  TextSubmitController.m
//  SystemInfoApp
//
//  Created by Czer on 9/27/23.
//

#import "TextSubmitController.h"
#import "TextModel.h"

@interface TextSubmitController ()

// Declare an instance of TextModel
@property (strong, nonatomic) TextModel *textModel;

@end


@implementation TextSubmitController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textModel = [[TextModel alloc] init];
}

- (IBAction)submitButtonClicked:(id)sender {
    [self.textModel updateText:self.textField.stringValue];
    self.displayText.stringValue = self.textModel.userText;
}

@end
