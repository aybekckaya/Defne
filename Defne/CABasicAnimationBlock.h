//
//  CABasicAnimationBlock.h
//  Defne
//
//  Created by aybek can kaya on 5/2/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CABasicAnimationBlock : CABasicAnimation
{
    
}


-(void) startAnimationView:(UIView *)viewAnimating finished:(void (^)(CABasicAnimationBlock *animation))finished;


@end
