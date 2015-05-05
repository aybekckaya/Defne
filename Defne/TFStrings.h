//
//  TFStrings.h
//  TFData
//
//  Created by aybek can kaya on 5/10/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFStrings : NSObject

+(NSRange)SearchString:(NSString *)Key InString:(NSString *)Str options:(NSStringCompareOptions)Opts;

+(BOOL)String:(NSString *)Search InString:(NSString *)BigStr;

+(NSString *)DataToString:(NSData *)data;

@end
