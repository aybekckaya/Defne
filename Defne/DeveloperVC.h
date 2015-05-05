//
//  DeveloperVC.h
//  Defne
//
//  Created by aybek can kaya on 5/4/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "AbstractVC.h"
#import <MessageUI/MessageUI.h>


@interface DeveloperVC : AbstractVC<MFMailComposeViewControllerDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UIView *viewDevelopIcon;

- (IBAction)closeOnTap:(id)sender;
- (IBAction)developOnTap:(id)sender;

@end
