//
//  SIFOString.m
//  SIFOMathString
//
//  Created by Leon on 2019/6/24.
//  Copyright © 2019 Leon. All rights reserved.
//

#import "SIFOString.h"
#import <CommonCrypto/CommonDigest.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/sysctl.h>
@implementation SIFOString

+ (NSString *)preg_replace:(NSString *)originString andPattern:(NSString *)pattern andReplacement:(NSString *)replacement{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionDotMatchesLineSeparators
                                                                             error:nil];
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:originString
                                                         options:NSMatchingReportProgress
                                                           range:NSMakeRange(0, [originString length])];
    
    if (firstMatch) {
        NSRange resultRange = [firstMatch rangeAtIndex:0];
        //Get data from string
        NSString *newStr = [originString stringByReplacingCharactersInRange:resultRange withString:replacement];
        return newStr;
    }
    return nil;
}

+ (NSString *)preg_replace_all:(NSString *)originString andPattern:(NSString *)pattern andReplacement:(NSString *)replacement{
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //2.利用规则测试字符串获取匹配结果
    NSArray *results = [regular matchesInString:originString options:0 range:NSMakeRange(0, originString.length)];
    for (long i = results.count - 1; i >= 0; i --) {
        NSTextCheckingResult *result = results[i];
        originString = [originString stringByReplacingCharactersInRange:result.range withString:replacement];
    }
    return originString;
}

+ (NSString *)preg_match:(NSString *)originString andPattern:(NSString *)pattern{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionDotMatchesLineSeparators
                                                                             error:&error];
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:originString
                                                         options:NSMatchingReportProgress
                                                           range:NSMakeRange(0, [originString length])];
    
    if (firstMatch) {
        NSRange resultRange = [firstMatch rangeAtIndex:0];
        //Get data from string
        NSString *result = [originString substringWithRange:resultRange];
        return result;
    }
    return nil;
}

+ (NSArray *)preg_match_all:(NSString *)originString andPattern:(NSString *)pattern{
    //1.1将正则表达式设置为OC规则
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //2.利用规则测试字符串获取匹配结果
    NSArray *results = [regular matchesInString:originString options:0 range:NSMakeRange(0, originString.length)];
    NSMutableArray *returnArr = [[NSMutableArray alloc] initWithCapacity:results.count];
    for (NSTextCheckingResult *result in results) {
        [returnArr addObject:[originString substringWithRange:result.range]];
    }
    return returnArr;
}

+ (NSString*)dataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

+ (NSArray *)sortArr:(NSArray *)originArr andKey:(NSString *)key{
    NSSortDescriptor *secondDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:secondDescriptor, nil];
    NSArray *result = [originArr sortedArrayUsingDescriptors:sortDescriptors];
    return result;
}

+ (NSString *)getMD5:(NSString *)path {
    
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) {
        return nil;
    }
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 256 ];
        CC_MD5_Update(&md5, [fileData bytes], (unsigned)[fileData length]);
        //        CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
}

+ (NSString *)macAddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString *)removeFromString:(NSString *)originString andRemoveString:(NSString *)removeString{
    while ([originString hasPrefix:removeString])
    {
        originString = [originString substringFromIndex:1];
    }
    return originString;
}

+ (NSString *)removeLeadingTrailingSpaces:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return string;
}

+ (NSString *)removeAllSpaces:(NSString *)string{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}

+ (NSString*)reverseWordsInString:(NSString*)oldStr
{
    NSMutableString *newStr = [NSMutableString stringWithCapacity:oldStr.length];
    [newStr enumerateSubstringsInRange:NSMakeRange(0, oldStr.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
        [newStr appendString:substring];
    }];
    return newStr;
}
@end
