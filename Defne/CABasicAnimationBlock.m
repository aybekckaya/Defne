//
//  CABasicAnimationBlock.m
//  Defne
//
//  Created by aybek can kaya on 5/2/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "CABasicAnimationBlock.h"

@implementation CABasicAnimationBlock

typedef void (^ EndBlock)(CABasicAnimationBlock *);
EndBlock blockEnd;


-(void)startAnimationView:(UIView *)viewAnimating finished:(void (^)(CABasicAnimationBlock *))finished
{
    blockEnd = finished;
    self.delegate = self;
    [viewAnimating.layer addAnimation:self forKey:@"basicBlock"];
}


#pragma mark Inner Callback
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    blockEnd(self);
}


@end
