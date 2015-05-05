//
//  DefneScroll.h
//  Defne
//
//  Created by aybek can kaya on 3/26/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefneImage.h"
#import "UIImage+ResizeWise.h"

@interface DefneScroll : UIScrollView
{
    
}

@property(nonatomic,assign) NSMutableArray *arrImages;

-(void)addImage:(DefneImage *)imageDefne;

-(void)removeImage:(DefneImage *)imageDefne;


@end
