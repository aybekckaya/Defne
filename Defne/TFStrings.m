//
//  TFStrings.m
//  TFData
//
//  Created by aybek can kaya on 5/10/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "TFStrings.h"



@implementation TFStrings


+(NSRange)SearchString:(NSString *)Key InString:(NSString *)Str options:(NSStringCompareOptions )Opts
{
    if(Opts == (int)nil)
    {
        Opts=NSCaseInsensitiveSearch;
    }
    
    NSString *myString = Str;
    NSRange rangeValue = [myString rangeOfString:Key options:Opts];
    
    if (rangeValue.length > 0){
        
        return rangeValue;
        }
    return NSMakeRange(0, 0);
}


+(BOOL)String:(NSString *)Search InString:(NSString *)BigStr
{
    if ([self SearchString:Search InString:BigStr options:nil].length==0 ) {
        return NO;
    }
    
    return YES;
}


+(NSString *)DataToString:(NSData *)data
{
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}


@end
