//
//  NSString+MD5.m
//  NIMOnlyRTC
//
//  Created by Nick Deng on 2017/6/28.
//  Copyright © 2017年 Nick Deng. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MD5)

-(NSString *)stringToMD5{
    const char *cstr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    
    NSMutableString *saveResult = [NSMutableString string];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x",result[i]];
    }
    
    return saveResult;
}

@end
