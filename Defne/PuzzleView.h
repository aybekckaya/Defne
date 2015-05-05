//
//  PuzzleView.h
//  Defne
//
//  Created by aybek can kaya on 3/19/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "DynamicView.h"

@class PuzzleView;
@protocol PuzzleViewDelegate <NSObject>

-(void)puzzleView:(PuzzleView *) puzzleView didStartDraggingLocation:(CGPoint) locationStart;

-(void)puzzleView:(PuzzleView *)puzzleView didMovedToLocation:(CGPoint)locationMoved;

-(void)puzzleView:(PuzzleView *)puzzleView didEndDraggingLocation:(CGPoint)locationFinal;

@end

@interface PuzzleView : DynamicView
{
    
}

// delegate
@property(nonatomic,weak) id<PuzzleViewDelegate> delegate;

// properties
@property(nonatomic) int ID;
@property(nonatomic) CGRect frameCorrect;
@property(nonatomic) CGRect frameBeforeTransform;


@end
