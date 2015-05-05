//
//  WinnerView.m
//  Defne
//
//  Created by aybek can kaya on 3/28/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "WinnerView.h"

@implementation WinnerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    recTap.numberOfTapsRequired = 1;
    recTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:recTap];
    
}


-(void)showWithView:(UIView *)theView
{
    UIImage *screen = [theView screenShot];
    UIImage *blurImage = [screen applyBlurWithRadius:1.8 tintColor:[UIColor colorWithR:0 G:0 B:0 Alpha:0.5] saturationDeltaFactor:10 maskImage:nil];
    
    self.imViewBackground.image = blurImage;
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

-(void)hide
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
    }];

}

@end
