//
//  TextModel.h
//  SystemInfoApp
//
//  Created by Czer on 9/27/23.
//

#import <Foundation/Foundation.h>


@interface TextModel : NSObject

// Text taken in from the user
@property (strong, nonatomic) NSString *userText;

// Update the userText based on input from the user
- (void)updateText:(NSString *)newText;

@end
