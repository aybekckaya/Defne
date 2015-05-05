//
//  DefneScroll.m
//  Defne
//
//  Created by aybek can kaya on 3/26/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "DefneScroll.h"

@implementation DefneScroll

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setArrImages:(NSMutableArray *)arrImages
{
    _arrImages = arrImages;
    
    // remove all Defne images
    
    for(id vv in self.subviews)
    {
        if([vv isKindOfClass:[UIImageView class]])
        {
            [(UIImageView *)vv removeFromSuperview];
            
        }
    }
    
    self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height);
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    // set Up scroll
    
    float XPos = 0;
    
    for(int i = 0 ; i<arrImages.count ; i++)
    {
        XPos = i*self.frame.size.width;
        CGRect frImView = CGRectMake(XPos, 0, self.frame.size.width, self.frame.size.height);
        
        DefneImage *imageDefne = arrImages[i];
        UIImage *imageObj = imageDefne.image;
        
        UIImage *restoredImage = [imageObj scaleToFitInSize:frImView.size];
        
        UIImageView *imView = [[UIImageView alloc]initWithFrame:frImView];
        imView.image = restoredImage;
        [self addSubview:imView];
        
    }
    
    self.contentSize = CGSizeMake(XPos, self.contentSize.height);
    
    
}



@end
