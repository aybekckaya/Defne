//
//  Game.h
//  Defne
//
//  Created by aybek can kaya on 3/19/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuzzleView.h"
#import "NSMutableArray+shuffle.h"
#import "DefneImage.h"

/*
  - Ana resim sonrasinda animasyon ile viewler son yerlerine yerlestirilebilir . 
 
 */


@class Game;
@protocol GameDelegate <NSObject>

-(void)game:(Game *)theGame didSuccess:(NSArray *)finalPuzzleArr;

-(void)gameShouldCheck:(Game *)theGame;

@end

@interface Game : NSObject
{
   // NSMutableArray *locations;
    CGRect emptyRect;
}

@property(nonatomic,weak) id<GameDelegate> delegate;

@property(nonatomic,strong) NSMutableArray *puzzleViewsArr;

@property(nonatomic,strong) PuzzleView *viewCurrentlyFocused;

@property(nonatomic,strong) DefneImage *imageDefneSelected;

// set when a static view moving with animation
@property(nonatomic,strong) PuzzleView *viewOnMoving;
//@property(nonatomic) CGRect emptyRect;

+(id)shared;

-(id)init;

-(void)shufflePuzzleArray;


/**
   focusedView : the square view that is on the Move
 */
-(void)focusedViewStartMove;

-(void)focusedViewOnMove;

-(void)focusedViewEndedMove;

-(PuzzleView *)puzzleViewAtPoint:(CGPoint) pt;

@end
