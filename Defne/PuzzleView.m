//
//  PuzzleView.m
//  Defne
//
//  Created by aybek can kaya on 3/19/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "PuzzleView.h"

@implementation PuzzleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    
    NSLog(@"TOUCHES BEGAN ID:  %d" , self.ID);
    
    if([self.delegate respondsToSelector:@selector(puzzleView:didStartDraggingLocation:)])
    {
        [self.delegate puzzleView:self didStartDraggingLocation:self.center];
    }
    
     [super touchesBegan:touches withEvent:event];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    
    if([self.delegate respondsToSelector:@selector(puzzleView:didMovedToLocation:)])
    {
        [self.delegate puzzleView:self didMovedToLocation:self.center];
    }
    
      [super touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    
    if([self.delegate respondsToSelector:@selector(puzzleView:didEndDraggingLocation:)])
    {
        [self.delegate puzzleView:self didEndDraggingLocation:self.center];
    }
    
     [super touchesEnded:touches withEvent:event];
}

@end
