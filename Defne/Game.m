//
//  Game.m
//  Defne
//
//  Created by aybek can kaya on 3/19/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "Game.h"

@implementation Game

+(id)shared
{
    static Game *gm = nil;
    
    if(gm == nil)
    {
        gm = [[self alloc]init];
    }
    
    return gm;
}

-(id)init
{
    if(self = [super init])
    {
        
    }
    
    return self;
}


#pragma mark Setters


-(void)setPuzzleViewsArr:(NSMutableArray *)puzzleViewsArr
{
    _puzzleViewsArr = puzzleViewsArr;
    
    /*
    locations = [[NSMutableArray alloc]init];
     for(UIView *vv in puzzleViewsArr)
     {
         CGRect loc = vv.frame;
         NSLog(@"loca : %@" , NSStringFromCGRect(loc));
         NSValue *valRect = [NSValue valueWithCGRect:loc];
         [locations addObject:valRect];
     }
    */
    // Do not make any action (infinite loop probability !!!! )
    
    
}



#pragma mark game initializers 

-(void)shufflePuzzleArray
{
   
    [self.puzzleViewsArr shuffle];
    
    
    //NSLog(@"Puzzle Array Debug : %@" , [self.puzzleViewsArr debugDescription]);
    
    // debug
    /*
    for(PuzzleView *theView  in self.puzzleViewsArr)
    {
        NSLog(@"Puzzle View Id (after shuffle ) : %d" , theView.ID);
    }
    */
}


#pragma mark GAMER

/**
 focusedView : the square view that is on the Move
 */
-(void)focusedViewStartMove
{
    CGRect frame = self.viewCurrentlyFocused.frame;
    emptyRect = frame;
}

-(void)focusedViewOnMove
{
    
}


-(void)focusedViewEndedMove
{
    PuzzleView *pzView = [self puzzleViewAtPoint:self.viewCurrentlyFocused.center];
    NSLog(@"puzzle view Bottom ID: %d" , pzView.ID);
    
    // moving views
    
    if(pzView == nil)
    {
        
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.viewCurrentlyFocused.frame = emptyRect;
            } completion:^(BOOL finished) {
                
                
                if([self.delegate respondsToSelector:@selector(gameShouldCheck:)])
                {
                    [self.delegate gameShouldCheck:self];
                }
                
            }];
    }
    else
    {
        CGRect nextRect = pzView.frame;
        
         [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
             self.viewCurrentlyFocused.frame = nextRect;
             pzView.frame = emptyRect;
         } completion:^(BOOL finished) {
             
             if([self.delegate respondsToSelector:@selector(gameShouldCheck:)])
             {
                 [self.delegate gameShouldCheck:self];
             }
             
         }];
    }
    
    
    
}


-(void)moveView:(PuzzleView *)theView ToFrame :(CGRect )finalFrame
{
    
}

-(PuzzleView *)puzzleViewAtPoint:(CGPoint)pt
{
    for(PuzzleView *view in self.puzzleViewsArr)
    {
        if(CGRectContainsPoint(view.frame, pt))
        {
            if(view.ID != self.viewCurrentlyFocused.ID)
            {
                 return view;
            }
           
        }
    }
    return nil;
}

@end
