//
//  SIFOString.h
//  SIFOMathString
//
//  Created by Leon on 2019/6/24.
//  Copyright © 2019 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIFOString : NSObject

/**
 正则替换原始数据中第一个

 @param originString 原始字符串
 @param pattern 正则表达式
 @param replacement 需要替换的字符串
 @return 替换过的字符串
 */
+ (NSString *)preg_replace:(NSString *)originString andPattern:(NSString *)pattern andReplacement:(NSString *)replacement;

/**
 正则替换所有

 @param originString 原始字符串
 @param pattern 正则表达式
 @param replacement 需要替换的字符串
 @return 替换过的字符串
 */
+ (NSString *)preg_replace_all:(NSString *)originString andPattern:(NSString *)pattern andReplacement:(NSString *)replacement;


/**
 正则匹配字符串 获取第一个

 @param originString 原始字符串
 @param pattern 正则表达式
 @return 查找到的字符串
 */
+ (NSString *)preg_match:(NSString *)originString andPattern:(NSString *)pattern;


/**
 正则匹配字符串 获取所有

 @param originString 原始字符串
 @param pattern 正则表达式
 @return 查找到的字符串数组
 */
+ (NSArray *)preg_match_all:(NSString *)originString andPattern:(NSString *)pattern;

/** 接口名称: 转json
 *
 */
+ (NSString*)dataTOjsonString:(id)object;

/** 接口名称: json转字典
 *
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/** 接口名称: 数组排序 数组中为dictionary key是字典中的某个key
 *
 */
+ (NSArray *)sortArr:(NSArray *)originArr andKey:(NSString *)key;

/** 接口名称: 文件md5编码
 *
 */
+ (NSString *)getMD5:(NSString *)path;

/** 接口名称: 获取mac地址
 *
 */
+ (NSString *)macAddress;

/** 接口名称: 去除字符串开头 如#
 *
 */
+ (NSString *)removeFromString:(NSString *)originString andRemoveString:(NSString *)removeString;

/** 接口名称: 去除字符串开头和结尾空格
 *
 */
+ (NSString *)removeLeadingTrailingSpaces:(NSString *)string;

/** 接口名称: 去除字符串全部空格
 *
 */
+ (NSString *)removeAllSpaces:(NSString *)string;

/** 接口名称: 反转字符串
 *
 */
+ (NSString*)reverseWordsInString:(NSString*)oldStr;
@end

NS_ASSUME_NONNULL_END
