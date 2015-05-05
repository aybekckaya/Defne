//
//  DynamicView.m
//  Defne
//
//  Created by aybek can kaya on 3/19/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "DynamicView.h"

@implementation DynamicView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    //UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    
    //[self addGestureRecognizer:panGestureRecognizer];
}

/*
-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)recPan
{
    UIView *viewSuper = self.superview;
    CGPoint touchLocation = [recPan locationInView:viewSuper];
    
    self.center = touchLocation;
}
*/


#pragma mark Touches

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *theTouchesSet = [event allTouches];
    
    UITouch *touch = [theTouchesSet anyObject];
    CGPoint touchLocation = [touch locationInView:self.superview];
    
    self.center = touchLocation;
    
    
    // transform
    
    CGAffineTransform trNew = CGAffineTransformMakeScale(1.3, 1.3);
    //self.transform = trNew;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:0 animations:^{
       
       // self.transform = trNew;
    } completion:^(BOOL finished) {
        
    }];
    
    
    // bring this view to front
    
    [self.superview bringSubviewToFront:self];

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *theTouchesSet = [event allTouches];
    
    UITouch *touch = [theTouchesSet anyObject];
    CGPoint touchLocation = [touch locationInView:self.superview];
    
    self.center = touchLocation;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGAffineTransform trNew = CGAffineTransformMakeScale(1.0, 1.0);
    self.transform = trNew;
}



@end
