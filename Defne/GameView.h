//
//  GameView.h
//  Defne
//
//  Created by aybek can kaya on 3/19/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ResizeWise.h"
#import "PuzzleView.h"

@interface GameView : UIView
{
    
}

// STRICT PROPERTIES

@property(nonatomic) int numberOfColumsAtEachRow;


// properties
@property(nonatomic) float lengthOfSideAtEachTile;


/*
 
 currYPos = 0;
 for(int i = 0 ; i<viewsPuzzle.count ; i++)
 {
 // int theID = i+1;
 
 if(i % numColumns == 0)
 {
 if(i != 0)
 {
 currYPos += lengthOfEachSide;
 }
 }
 
 int theIndex = i % numColumns;
 
 CGRect newRectangle = CGRectMake(theIndex*lengthOfEachSide, currYPos, lengthOfEachSide, lengthOfEachSide);
 
 PuzzleView *theInnerPuzzleView = (PuzzleView *)viewsPuzzle[i];
 theInnerPuzzleView.frame = newRectangle;
 
 [finalPuzzleViewsArr addObject:theInnerPuzzleView];
 
 [self.viewGame addSubview:theInnerPuzzleView];
 
 }

 
 */


//Init

/**
   uses wise crop to get views. if strict properties not given , crop big image so that cropped images fill this view. This function will not push the cropped image views on itself.
  
 @return: array (UIImage) of cropped tiles.
 
 */
-(NSMutableArray *)imagesFromRealImage:(UIImage *)realImage;


-(void)update;

@end
