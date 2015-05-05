//
//  UIView+staticAdditions.m
//  AddressFinder
//
//  Created by aybek can kaya on 9/24/14.
//  Copyright (c) 2014 aybek can kaya. All rights reserved.
//

#import "UIView+staticAdditions.h"

@implementation UIView (staticAdditions)

- (UIImage *) screenShot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


-(UIImageView *)screenShotRenderedToImageView
{
    UIImageView *imView = [[UIImageView alloc]init];
    
    UIImage *image = [self screenShot];
    imView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imView.image = image;
    
    return imView;
    
}

@end
