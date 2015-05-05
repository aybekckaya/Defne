//
//  ControlView.h
//  Defne
//
//  Created by aybek can kaya on 3/26/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlShare.h"
#import "DefneScroll.h"
#import "Plist.h"

@class ControlView;
@protocol ControlViewDelegate <NSObject>

-(void)controlView:(ControlView *)controlView didTranslatedToProgress:(float) progress;

-(void)controlView:(ControlView *)controlView didEndedTranslationToProgress:(float)progress;

-(void)controlViewGalleryOnTap;

-(void)controlViewTakePhotoOnTap;

-(void)controlViewTrashDidTappedForImage:(DefneImage *)imageDefne;

-(void)controlViewImageDidSelected:(DefneImage *)imageDefne ShouldClose:(BOOL) closeView;

-(BOOL)controlViewShouldOpen;

-(void)controlViewDidTappedDeveloperBtn;


@end

@interface ControlView : UIView<UIGestureRecognizerDelegate>
{
    DefneImage *currentDefneImage;
}

@property(nonatomic,weak) id<ControlViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imViewPuzzle;

@property (weak, nonatomic) IBOutlet DefneScroll *scrollDefne;


/**
   may set from indexVC or from this class
 */
@property(nonatomic) BOOL onShow;


-(void)supplyDefneImage:(DefneImage *)imageDefne;

-(void)setNeedsBlink:(BOOL)shouldBlink;

-(BOOL)needsBlink;

-(void)blinkRandom;

-(void)blink;

- (IBAction)galleryDidTapped:(id)sender;
- (IBAction)takePhotoDidTapped:(id)sender;
- (IBAction)refreshDidTapped:(id)sender;
- (IBAction)trashOnTap:(id)sender;

- (IBAction)developerOnTap:(id)sender;



@end
