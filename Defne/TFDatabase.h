//
//  TFDatabase.h
//  fmdbTry
//
//  Created by aybek can kaya on 4/30/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "TFStrings.h"

@interface TFDatabase : NSObject
{
    NSString *Database_Name;
    FMDatabase *database;
}


@property(nonatomic, strong) NSString *Database_Name;
@property (nonatomic,strong) FMDatabase *database;



-(id) InitWithDatabaseName:(NSString *) DBName;
-(id) Query:(NSString *) query;
-(void)Close;

@end
