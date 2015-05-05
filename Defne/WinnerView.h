//
//  WinnerView.h
//  Defne
//
//  Created by aybek can kaya on 3/28/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+staticAdditions.h"
#import "UIImage+ImageEffects.h"
#import "UIColor+converter.h"

@protocol WinnerViewDelegate <NSObject>

-(void)winnerViewDidClosed;

@end

@interface WinnerView : UIView
{
    
}
@property(nonatomic,weak) id<WinnerViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *imViewCup;

@property (weak, nonatomic) IBOutlet UIImageView *imViewBackground;


-(void)showWithView:(UIView *)theView;

-(void)hide;

@end
