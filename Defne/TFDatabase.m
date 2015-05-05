//
//  TFDatabase.m
//  fmdbTry
//
//  Created by aybek can kaya on 4/30/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "TFDatabase.h"


@implementation TFDatabase

@synthesize Database_Name,database;


//Private Methods:

-(void) checkAndCreateDatabase:(NSString *)databasePath DatabaseName:(NSString *) DBName {
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
    
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
    
	// If the database already exists then return without doing anything
	if(success) return;
    
	// If not then proceed to copy the database from the application to the users filesystem
    
    
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DBName];
    
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
	
}




// Public Methods 




-(void)Close
{
    [database close];
    
}

-(id)InitWithDatabaseName:(NSString *)DBName
{
    
    
    // Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *databasePath = [documentsDir stringByAppendingPathComponent:DBName];
    
    
    
    [self checkAndCreateDatabase:databasePath DatabaseName:DBName];
    

     database = [FMDatabase databaseWithPath:databasePath];
    
    
    return self;
}


// Query Turune bakacak Select Disinda ise UPDATE yapacak 
-(id)Query:(NSString *)query
{
    // Determine that query is whether SELECT query or not.
    NSRange Rng=[TFStrings SearchString:@"SELECT" InString:query options:NSCaseInsensitiveSearch];
    
    
    
    // TFStrings
    
    if(Rng.length>0)
    {
        // Select Query
        [database open];
        FMResultSet *Res=[database executeQuery:query];
        
        // [database close];
        
        return (FMResultSet *)Res;
    }
    return [NSNumber numberWithBool:[self UpdateQuery:query]];

    
   
}

// Private Method 
// returns boolean result
-(BOOL) UpdateQuery:(NSString *) query
{
    [database open];
    
    return [database executeUpdate:query];
}



@end
