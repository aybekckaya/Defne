//
//  ControlShare.h
//  Defne
//
//  Created by aybek can kaya on 3/26/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TFDatabase.h"
#import "DefneImage.h"

@protocol ControlShareDelegate <NSObject>

-(void)controlShareDidStartSaveDefneImage:(DefneImage *)image;

-(void)controlShareDidEndSaveDefneImage:(DefneImage *)image;

@end


@interface ControlShare : NSObject<DefneImageDelegate>
{
    
}

@property(nonatomic,weak) id<ControlShareDelegate> delegate;
@property(nonatomic,strong) DefneImage *defneImageOnScreen;

+(id)defaultControl;

-(void)saveImage:(DefneImage *)imageToSave;

-(void)removeImage:(DefneImage *)imageToRemove;

-(DefneImage *)randomImage;



-(NSMutableArray *)allImages;

@end
