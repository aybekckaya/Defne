//
//  UIImage+ResizeWise.m
//  ImageResizerWise
//
//  Created by aybek can kaya on 10/6/14.
//  Copyright (c) 2014 aybek can kaya. All rights reserved.
//

#import "UIImage+ResizeWise.h"
#import "NYXImagesKit.h"

@implementation UIImage (ResizeWise)

-(UIImage *)scaleToFitInSize:(CGSize)size
{
    // ratio of original image to ratio of longer edge of size
    
    float longerEdge;
    if(size.height > size.width)
    {
        longerEdge = size.height;
        float imgHeight = self.size.height;
        
        float ratio = (float) longerEdge/imgHeight;
        UIImage *resizedImg = [self scaleByFactor:ratio];
        
        NSLog(@"new Size: %@", NSStringFromCGSize(resizedImg.size));
        
        // crop
        UIImage *croppedImg = [resizedImg cropToSize:CGSizeMake(size.width, resizedImg.size.height) usingMode:NYXCropModeCenter];
        
        return  croppedImg;
    }
    else
    {
        longerEdge = size.width;
        float imgWidth = self.size.width;
        
        float ratio = (float) longerEdge/imgWidth;
        UIImage *resizedImg = [self scaleByFactor:ratio];
        
        NSLog(@"new Size: %@", NSStringFromCGSize(resizedImg.size));
        
        // crop
        UIImage *croppedImg = [resizedImg cropToSize:CGSizeMake(resizedImg.size.width, size.height) usingMode:NYXCropModeCenter];
        
        return  croppedImg;

    }
    
    
    return nil;
}

@end
