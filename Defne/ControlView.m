//
//  ControlView.m
//  Defne
//
//  Created by aybek can kaya on 3/26/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "ControlView.h"

#define DEFNE_DEFAULTS_LIST_NAME @"DefneDefaults"

#define DEFNE_DEFAULTS_NEEDS_BLINK_KEY @"needsBlink"


@implementation ControlView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    UIPanGestureRecognizer *rec = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    rec.delegate = self;
    [self addGestureRecognizer:rec];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self.frame = bounds;
    
    // set up defne scroll
  //  [self setUpDefneScroll];
    
    self.imViewPuzzle.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewDidTapped)];
    recTap.numberOfTapsRequired = 1;
    recTap.numberOfTouchesRequired = 1;
    [self.imViewPuzzle addGestureRecognizer:recTap];
    
    [self updatePuzzleImage];
    
    [self initList];
    
}

-(void)initList
{
    BOOL listExist=[Plist listExists:DEFNE_DEFAULTS_LIST_NAME];
    if(listExist == NO)
    {
        [self setNeedsBlink:YES];
    }
}


-(void)handlePan:(UIPanGestureRecognizer *)recPan
{
    BOOL shouldOpen = YES;
    
    if([self.delegate respondsToSelector:@selector(controlViewShouldOpen)])
    {
        shouldOpen = [self.delegate controlViewShouldOpen];
    }
    
    
    if(shouldOpen == YES)
    {
        float translation = [recPan translationInView:self].x;
        // NSLog(@"translation : %f " , translation);
        float progress = translation / self.bounds.size.width;
        // NSLog(@"progress : %f" , progress);
        
        CGRect currFrame = self.frame;
        
        if(translation > 0)
        {
            translation = 0;
        }
        
        currFrame.origin.x = translation;
        self.frame= currFrame;
        
        if(recPan.state == UIGestureRecognizerStateChanged)
        {
            if([self.delegate respondsToSelector:@selector(controlView:didTranslatedToProgress:)])
            {
                [self.delegate controlView:self didTranslatedToProgress:progress];
            }
        }
        else if(recPan.state == UIGestureRecognizerStateEnded)
        {
            if([self.delegate respondsToSelector:@selector(controlView:didEndedTranslationToProgress:)])
            {
                [self.delegate controlView:self didEndedTranslationToProgress:progress];
            }
        }
    }
    
   
    
   
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)updatePuzzleImage
{
    
    DefneImage *imgGiven = [[ControlShare defaultControl] randomImage];
    currentDefneImage = imgGiven;
    UIImage *imgObject = imgGiven.image;
    UIImage *imgObjectProcessed = [imgObject scaleToFitInSize:self.imViewPuzzle.frame.size];
    
    self.imViewPuzzle.image = imgObjectProcessed;
}


-(void)imageViewDidTapped
{
    if([self.delegate respondsToSelector:@selector(controlViewImageDidSelected:ShouldClose:)])
    {
        [self.delegate controlViewImageDidSelected:currentDefneImage ShouldClose:YES];
    }
}


-(void)supplyDefneImage:(DefneImage *)imageDefne
{
    currentDefneImage = imageDefne;
    
    UIImage *imgObject = currentDefneImage.image;
    UIImage *imgObjectProcessed = [imgObject scaleToFitInSize:self.imViewPuzzle.frame.size];
    
    self.imViewPuzzle.image = imgObjectProcessed;
}

#pragma mark DefneScroll

-(void)setUpDefneScroll
{
    NSMutableArray *allImages = [[ControlShare defaultControl] allImages];
    self.scrollDefne.arrImages = allImages;
}


- (IBAction)galleryDidTapped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(controlViewGalleryOnTap)])
    {
        [self.delegate controlViewGalleryOnTap];
    }
}

- (IBAction)takePhotoDidTapped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(controlViewTakePhotoOnTap)])
    {
        [self.delegate controlViewTakePhotoOnTap];
    }
}

- (IBAction)refreshDidTapped:(id)sender
{
    DefneImage *image = [[ControlShare defaultControl] randomImage];
    [self supplyDefneImage:image];
}

- (IBAction)trashOnTap:(id)sender
{
    NSMutableArray *arrImages  = [[ControlShare defaultControl] allImages];
    
    if(arrImages.count > 1)
    {
        [currentDefneImage remove];
        [self refreshDidTapped:nil];
        
        ControlShare *share = [ControlShare defaultControl];
        DefneImage *imageOnScreen = share.defneImageOnScreen;
        if(currentDefneImage.ID == imageOnScreen.ID)
        {
            if([self.delegate  respondsToSelector:@selector(controlViewImageDidSelected:ShouldClose:)])
            {
                [self.delegate controlViewImageDidSelected:currentDefneImage ShouldClose:NO];
            }
        }
    }
    else
    {
        
    }
   
}

- (IBAction)developerOnTap:(id)sender
{
    if([self.delegate respondsToSelector:@selector(controlViewDidTappedDeveloperBtn)])
    {
        [self.delegate controlViewDidTappedDeveloperBtn];
    }
    
}


-(void)setNeedsBlink:(BOOL)shouldBlink
{
    
    if(shouldBlink == NO)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(blinkRandom) object:nil];
    }
    
    Plist *list = [[Plist alloc]initWithPlistName:DEFNE_DEFAULTS_LIST_NAME];
    
    [list write:[NSNumber numberWithBool:shouldBlink] Key:DEFNE_DEFAULTS_NEEDS_BLINK_KEY];
}

-(BOOL)needsBlink
{
    
    Plist *list = [[Plist alloc]initWithPlistName:DEFNE_DEFAULTS_LIST_NAME];
    int theVal = [[list read:DEFNE_DEFAULTS_NEEDS_BLINK_KEY] intValue];
    
    if(theVal == 1)
    {
        return YES;
    }
    
    return NO;
}

-(void)blinkRandom
{
    [self blink];
    int randomSeconds = 2+arc4random() % 6;
    [self performSelector:@selector(blinkRandom) withObject:nil afterDelay:randomSeconds];
}

-(void)blink
{
    
    if([self needsBlink] == NO)
    {
        return;
    }
    
    self.onShow = YES;
    
    float blinkPosition = self.frame.origin.x + 100;
    
    CGRect nextFrame = self.frame;
    nextFrame.origin.x  = blinkPosition;
    
    CGRect prevFrame = self.frame;
    prevFrame.origin.x = self.frame.origin.x;
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:0 animations:^{
    
        self.frame = nextFrame;
        
    } completion:^(BOOL finished) {
       
        
        
        [UIView animateWithDuration:0.8 delay:0.05 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:0 animations:^{
            
            self.frame = prevFrame;
            
        } completion:^(BOOL finished) {
            
            self.onShow = NO;
            
        }];

        
    }];
}




@end
