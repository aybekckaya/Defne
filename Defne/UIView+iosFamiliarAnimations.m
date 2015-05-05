//
//  UIView+iosFamiliarAnimations.m
//  Defne
//
//  Created by aybek can kaya on 5/2/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "UIView+iosFamiliarAnimations.h"

@implementation UIView (iosFamiliarAnimations)


-(void)jumpDirection:(DirectionJump)theDirection To:(float)toPos
{
    if(theDirection == kJumpDirectionVertical)
    {
        
    }
    else if(theDirection == kJumpDirectionHorizontal)
    {
        [self jumpHelperKeyPath:@"position.x" finalPosDynamic:toPos];
    }
}


-(void)jumpHelperKeyPath:(NSString *)keypath finalPosDynamic:(float) finalPos
{
    float fromVal;
    
    if([keypath isEqualToString:@"position.x"])
    {
        fromVal = self.frame.origin.x;
    }
    else if([keypath isEqualToString:@"position.y"])
    {
         fromVal = self.frame.origin.y;
    }
    
    CABasicAnimationBlock *animationBlock = [CABasicAnimationBlock animation];
    animationBlock.keyPath = keypath;
    animationBlock.autoreverses = YES;
    animationBlock.fromValue = [NSNumber numberWithFloat:fromVal];
    animationBlock.toValue = [NSNumber numberWithFloat:finalPos];
    animationBlock.duration = 2;
    
    [animationBlock startAnimationView:self finished:^(CABasicAnimationBlock *animation) {
        NSLog(@"ANimation finished");
    }];
    
}

@end
