//
//  DeveloperVC.m
//  Defne
//
//  Created by aybek can kaya on 5/4/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "DeveloperVC.h"

@interface DeveloperVC ()

@end

@implementation DeveloperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewDevelopIcon.layer.cornerRadius = self.viewDevelopIcon.frame.size.height/2;
    self.viewDevelopIcon.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeOnTap:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (IBAction)developOnTap:(id)sender
{
    [self mailToDevelop];
}


#pragma mark Mailer 

-(void)mailToDevelop
{
    
    // Text Area
    
    NSString *emailTitle = @"Defne App";
    // Email Content
    NSString *messageBody = @"I am a talented IOS developer and want to help you to develop Defne app. Please add me to Defne's developer list.";
    
    
    NSArray *toRecipents = [NSArray arrayWithObject:@"defneapp@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // File Creation Area
    
   
    
    [self presentViewController:mc animated:YES completion:^{
        
    }];
    
    
    //attach file
    
    // https://developer.apple.com/library/ios/qa/qa1587/_index.html
    //https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/DocumentInteraction_TopicsForIOS/Articles/PreviewingandOpeningItems.html#//apple_ref/doc/uid/TP40010410-SW1
    
    //https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/DocumentInteraction_TopicsForIOS/Articles/RegisteringtheFileTypesYourAppSupports.html#//apple_ref/doc/uid/TP40010411-SW1
    
}

#pragma mark MAil compose Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    BOOL shouldGiveAlert = NO;
    
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
          
            shouldGiveAlert = YES;
           
          break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        if(shouldGiveAlert == YES)
        {
             [self showAlert];
        }
       
    }];
}

-(void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thanks" message:@"Thanks for your request. I am very happy now. I will contact you via  email in next few days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


@end
