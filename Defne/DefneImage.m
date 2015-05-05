//
//  DefneImage.m
//  Defne
//
//  Created by aybek can kaya on 3/26/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "DefneImage.h"

@implementation DefneImage

-(void)save
{
    TFDatabase *database = [[TFDatabase alloc]InitWithDatabaseName:@"Defne.sqlite"];
    
    
    
    if(self.ID == 0)
    {
        // id not defined
        NSString *query = @"SELECT * FROM DefneImages";
        int max = 0;
        
        FMResultSet *res = [database Query:query];
        
        while([res next])
        {
            int theID = [res intForColumn:@"id"];
            
            if(theID > max)
            {
                max = theID;
            }
                
        }
        
        self.ID = max+1;
        
    }
    
    if(self.imageName == nil)
    {
        // image Name Not defined
        
        NSString *imageName = [NSString stringWithFormat:@"%d" , self.ID];
        self.imageName = imageName;
    }
    
    // Save to DB
    NSString *queryToSave = [NSString stringWithFormat:@"INSERT INTO DefneImages(id,imageName, imageAppleName) VALUES(%d,'%@' , '%@')" , self.ID , self.imageName , self.appleName];
    
    [database Query:queryToSave];
    
    //Save to local Folder
    NSString *thePath = [self imagePath];
    
    // LOOK at image extension
    NSString *imageNameFull;
    NSData *imageData;
    
    if([[self.extension lowercaseString] isEqualToString:@"png"])
    {
        imageNameFull = [NSString stringWithFormat:@"%@.png" , self.imageName];
        imageData = UIImagePNGRepresentation(self.image);
    }
    else
    {
        imageNameFull = [NSString stringWithFormat:@"%@.jpg" , self.imageName];
        imageData = UIImageJPEGRepresentation(self.image, 1);
    }
    
    
    
    NSString *fullPath = [thePath stringByAppendingPathComponent:imageNameFull];
    
  //  NSFileManager *manager = [NSFileManager defaultManager];
   
   // save to folder
  //  [imageData writeToFile:fullPath atomically:YES];
    
    if([self.delegate respondsToSelector:@selector(defneImageDidStartSaving:)])
    {
        [self.delegate defneImageDidStartSaving:self];
    }
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [imageData writeToFile:fullPath atomically:YES];
        
        
        dispatch_async( dispatch_get_main_queue(), ^{
            
            if([self.delegate respondsToSelector:@selector(defneImageDidEndSaving:)])
            {
                [self.delegate defneImageDidEndSaving:self];
            }
            
        });
    });
    
}

-(void)remove
{
    NSString *thePath = [self imagePath];
    NSString *extensionStr = [self.extension lowercaseString];
    NSString *imageNameFull = [NSString stringWithFormat:@"%@.%@" , self.imageName , extensionStr];
    NSString *fullPath = [thePath stringByAppendingPathComponent:imageNameFull];
    
    [[NSFileManager defaultManager] removeItemAtPath:fullPath error:nil];
    
    // remove from DB
    
    TFDatabase *database = [[TFDatabase alloc]InitWithDatabaseName:@"Defne.sqlite"];
    NSString *queryToSave = [NSString stringWithFormat:@"DELETE FROM DefneImages WHERE id=%d" , self.ID];
    
    [database Query:queryToSave];

    
}


-(NSString *)imagePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    
    NSString *pathComp = [NSString stringWithFormat:@"/%@" , LOCAL_FOLDER_NAME];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:pathComp];
    NSError *error=nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    }

    
    return dataPath;
}


-(UIImage *)imageObject
{
    NSString *imPath = [self imagePath];
    NSString *imageName = [NSString stringWithFormat:@"%@.%@" , self.imageName, [self.extension lowercaseString]];
    NSString *imageFullPath = [imPath stringByAppendingPathComponent:imageName];
    NSData *imdata = [NSData dataWithContentsOfFile:imageFullPath];
    
    UIImage *img = [UIImage imageWithData:imdata];
    
    return img;
}

@end
