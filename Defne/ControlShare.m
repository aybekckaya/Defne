//
//  ControlShare.m
//  Defne
//
//  Created by aybek can kaya on 3/26/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "ControlShare.h"

@implementation ControlShare

+(id)defaultControl
{
    static ControlShare *sh = nil;
    if(sh == nil)
    {
        sh = [[self alloc]init];
    }
    
    return sh;
}


-(void)saveImage:(DefneImage *)imageToSave
{
    imageToSave.delegate = self;
    [imageToSave save];
}

#pragma mark Defne Image Delegate 

-(void)defneImageDidStartSaving:(DefneImage *)image
{
    if([self.delegate respondsToSelector:@selector(controlShareDidStartSaveDefneImage:)])
    {
        [self.delegate controlShareDidStartSaveDefneImage:image];
    }
}

-(void)defneImageDidEndSaving:(DefneImage *)image
{
    if([self.delegate respondsToSelector:@selector(controlShareDidEndSaveDefneImage:)])
        
    {
        [self.delegate controlShareDidEndSaveDefneImage:image];
    }
}

-(void)removeImage:(DefneImage *)imageToRemove
{
    [imageToRemove remove];
}


-(DefneImage *)randomImage
{
    NSMutableArray *arrMute= [self allImages];
    
    if(arrMute.count == 0)
    {
        return nil;
    }
    
    DefneImage *image =arrMute[arc4random()%arrMute.count];
    
  //  image = arrMute[1]; // Test
    
    return image;
}

-(NSMutableArray *)allImages
{
    
    NSString *query = @"SELECT * FROM DefneImages";
    
    TFDatabase *database = [[TFDatabase alloc]InitWithDatabaseName:@"Defne.sqlite"];
    
    FMResultSet *res = [database Query:query];
    
    NSMutableArray *arrImages = [[NSMutableArray alloc]init];
    
    while([res next])
    {
        int theID = [res intForColumn:@"id"];
        NSString *imageName = [res stringForColumn:@"imageName"];
        NSString *appleName = [res stringForColumn:@"imageAppleName"];
        
        DefneImage *imageInner = [[DefneImage alloc]init];
        imageInner.ID = theID;
        imageInner.delegate = self;
        imageInner.imageName = imageName;
        imageInner.appleName = appleName;
        
        // extensions setter
        NSArray *components = [imageInner.appleName componentsSeparatedByString:@"&ext="];
        NSString *ext = [components lastObject];
        imageInner.extension = ext;
        
        // Get image from local path
        UIImage *img = [imageInner imageObject];
        imageInner.image = img;
        
        [arrImages addObject:imageInner];
    }
    
    return arrImages;
}


@end
