//
//  DefneImage.h
//  Defne
//
//  Created by aybek can kaya on 3/26/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "TFDatabase.h"

#define LOCAL_FOLDER_NAME @"DefneImagesAll"

@class DefneImage;
@protocol DefneImageDelegate <NSObject>

-(void)defneImageDidStartSaving:(DefneImage *)image;

-(void)defneImageDidEndSaving:(DefneImage *)image;

@end

@interface DefneImage : NSObject
{
    
}

@property(nonatomic,weak) id<DefneImageDelegate> delegate;

@property(nonatomic) int ID;
@property(nonatomic,strong) NSString *imageName;
@property(nonatomic,strong) NSString *appleName;
@property(nonatomic,strong) NSString *extension;

@property(nonatomic,strong) UIImage *image;

-(void)save;

-(void)remove;

-(UIImage *)imageObject;

@end
