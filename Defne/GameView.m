//
//  GameView.m
//  Defne
//
//  Created by aybek can kaya on 3/19/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "GameView.h"


// mother language C

int gcd(int m, int n)
{
    
    int t, r;
    
    if (m < n)
    {
        t = m;
        m = n;
        n = t;
    }
    
    r = m % n;
    
    if (r == 0)
    {
        return n;
    } else
    {
        return gcd(n, r);
    }
}



@implementation GameView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




-(void)update
{
    NSArray *viewsAll = self.subviews;
    
    float currYPos = 0;
    int count = 0;
    for(id vv in viewsAll)
    {
        if([vv isKindOfClass:[PuzzleView class]])
        {
            
            if(count%self.numberOfColumsAtEachRow == 0)
            {
                if(count != 0)
                {
                    currYPos+= self.lengthOfSideAtEachTile;
                }
            }
            
            int theIndex = count % self.numberOfColumsAtEachRow;
            
            CGRect newRectangle = CGRectMake(theIndex*self.lengthOfSideAtEachTile, currYPos, self.lengthOfSideAtEachTile, self.lengthOfSideAtEachTile);
            PuzzleView *theViewInner = (PuzzleView *)vv;
            theViewInner.frame = newRectangle;
            
            count++;
        }
    }
}


-(NSMutableArray *)imagesFromRealImage:(UIImage *)realImage
{
    
    // each squares' edge length calculations
    
    if(self.numberOfColumsAtEachRow < 0)
    {
        self.numberOfColumsAtEachRow = 0;
    }
    
    float length;
    UIView *superView = self;
    CGRect superViewFrame = superView.frame;
    
    int widthINT = superViewFrame.size.width;
    
    if(self.numberOfColumsAtEachRow == 0)
    {
         // not defined
        
        // try to divide by three if not divided divide to four or 5
        BOOL canBeDivided = NO;
    
        
        while(canBeDivided == NO)
        {
               if(widthINT % 3 == 0)
               {
                   canBeDivided = YES;
                   self.numberOfColumsAtEachRow = 3;
                   
               }
            else if(widthINT % 4 == 0)
            {
                canBeDivided = YES;
                self.numberOfColumsAtEachRow = 4;
            }
            else if(widthINT % 5 == 0)
            {
                canBeDivided = YES;
                self.numberOfColumsAtEachRow = 5;
            }
            else
            {
                widthINT --;
            }
        }
        
        length = widthINT / self.numberOfColumsAtEachRow;
        
        int numRows = self.frame.size.height / length;
        
        // finalize the frame
        CGRect fr = self.frame;
        fr.size.width = widthINT;
        fr.size.height = length*numRows;
        
        self.frame = fr;
        
    }
    else
    {
        // numOf Columns defined
        
        BOOL canBeDivided = NO;
        
        while (canBeDivided == NO)
        {
            
            if(widthINT % self.numberOfColumsAtEachRow == 0)
            {
                canBeDivided = YES;
            }
            else
            {
                  widthINT --;
            }
            
        }
        
        length = widthINT / self.numberOfColumsAtEachRow;
        
        int numRows = self.frame.size.height / length;
        
        // finalize the frame
        CGRect fr = self.frame;
        fr.size.width = widthINT;
        fr.size.height = length*numRows;
        
        self.frame = fr;
        
        
    }
    
    NSLog(@"Game view frame : %@" , NSStringFromCGRect(self.frame));
    
    self.center = self.superview.center;
    // resize
    UIImage *imageCropped = [realImage scaleToFitInSize:self.frame.size];
    
    self.lengthOfSideAtEachTile = length;
    
    int numberOfRows = self.superview.frame.size.height / length;
    int numberOfColumns = self.superview.frame.size.width / length;
    
    // crop big image
    NSMutableArray *finalArr = [[NSMutableArray alloc]init];
    
    for(int row = 0 ; row<numberOfRows ; row ++)
    {
        float currentTopPos = row*length;
        for(int column = 0 ; column<numberOfColumns ; column++)
        {
            float currentLeftPos = column*length;
            CGRect rectToCrop = CGRectMake(currentLeftPos, currentTopPos, length, length);
            
            CGImageRef imageRefForCrop = CGImageCreateWithImageInRect([imageCropped CGImage], rectToCrop);
            UIImage *finalInnerImage = [UIImage imageWithCGImage:imageRefForCrop];
            
            if(finalInnerImage != nil)
            {
                   [finalArr addObject:finalInnerImage];
            }
         
        }
    }
    
    /*
    for(int left = 0 ; left < numberOfColumns ; left++ )
    {
        float currentLeftPt = left * length;
        for(int top = 0 ; top < numberOfRows ; top ++)
        {
            float currentTopPt = top * length;
            
            CGRect rectToCrop = CGRectMake(currentLeftPt, currentTopPt, length, length);
           
            CGImageRef imageRefForCrop = CGImageCreateWithImageInRect([imageCropped CGImage], rectToCrop);
            UIImage *finalInnerImage = [UIImage imageWithCGImage:imageRefForCrop];
            [finalArr addObject:finalInnerImage];
        }
    }
     */
    
    
    
    
    
    return finalArr;
}

@end




