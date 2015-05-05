//
//  IndexVC.h
//  Defne
//
//  Created by aybek can kaya on 3/19/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractVC.h"
//#import "PuzzleView.h"
#import "UIColor+converter.h"

#import "Story.h"

#import "UIImage+ImageEffects.h"
#import "UIView+staticAdditions.h"

#import "Game.h"
#import  "GameView.h"
#import "ControlView.h"
#import "WinnerView.h"

#import "DeveloperVC.h"

//#import "UIView+iosFamiliarAnimations.h"

@interface IndexVC : AbstractVC<PuzzleViewDelegate,GameDelegate,UIGestureRecognizerDelegate,ControlViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate, ControlShareDelegate,WinnerViewDelegate>
{
    UIImageView *imViewBlur;
    
    ControlView *viewControl;
    BOOL controlViewShouldOpen;
    
    WinnerView *viewWinner;
}


// Test Views
//@property (strong, nonatomic) IBOutletCollection(PuzzleView) NSArray *puzzleViewsArr;

@property (weak, nonatomic) IBOutlet GameView *viewGame;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *viewsInit;


/*
    on next version puzzle may work with photos taken instantly
 */
- (IBAction)photoOnTap:(id)sender;


- (IBAction)galleryOnTap:(id)sender;

@end
