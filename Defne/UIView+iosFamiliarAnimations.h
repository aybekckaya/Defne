//
//  UIView+iosFamiliarAnimations.h
//  Defne
//
//  Created by aybek can kaya on 5/2/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CABasicAnimationBlock.h"

typedef enum JumpDirection
{
    kJumpDirectionVertical,
    kJumpDirectionHorizontal
    
}DirectionJump;

@interface UIView (iosFamiliarAnimations)

/*
 CABasicAnimation *animation = [CABasicAnimation animation];
 animation.keyPath = @"position.x";
 animation.fromValue = @77;
 animation.toValue = @455;
 animation.duration = 1;
 
 [rocket.layer addAnimation:animation forKey:@"basic"];
 
 */


-(void)jumpDirection:(DirectionJump) theDirection To:(float)toPos;

@end
