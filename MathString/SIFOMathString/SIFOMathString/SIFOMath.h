//
//  SIFOMath.h
//  SIFOMathString
//
//  Created by Leon on 2019/6/24.
//  Copyright © 2019 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIFOMath : NSObject

/**
 十六进制转二进制

 @param hex 十六进制
 @return 二进制
 */
+ (NSString *)hexToBinary:(NSString *)hex;//hex to binary

/**
 二进制转十六进制
 
 @param binary 二进制
 @return 十六进制
 */
+ (NSString *)binaryToHex:(NSString *)binary;//binary to hex

/**
十进制 转二进制
 @param length 返回字符串长度 不足补0
 @return 二进制
 */
+ (NSString *)decimalToBinary:(uint16_t)tmpid backLength:(int)length;//decimal to binary

/**
 十六进制 转十进制
 @param hexString 十六进制
 @return 十进制
 */
+ (int)hexToDecimal:(NSString *)hexString;

/**
十进制  转十六进制
 */
+(NSString *)decimalToHex:(int)value withLength:(int)length;

/**
 数据转十六进制
 */
+ (NSString *) dataToHex:(NSData *)data lcation:(int)location length:(int)length;

/**
 数据转换
 */
+ (NSString *)littleEndianToBigEndian:(NSString *)string;

/**
 *  convert hex string to binary string
 *
 *  @param hex hex string
 *
 *  @return binary string
 */
- (NSString *)hex2Binary:(NSString *)hex;

/**
 *  convert binary string to hex string
 *
 *  @param binary binary string
 *
 *  @return hex string
 */
- (NSString *)binary2Hex:(NSString *)binary;

/**
 *  convert decimal value to binary string
 *
 *  @param decimal decimal value
 *
 *  @return binary string
 */
- (NSString *)decimal2Binary:(NSInteger)decimal;

/**
 *  convert binary string to decimal value
 *
 *  @param binary bianry string
 *
 *  @return decimal vlaue
 */
- (NSInteger)binary2Decimal:(NSString *)binary;

/**
 *  convert decimal value to hex string
 *
 *  @param decimal decimal value
 *
 *  @return hex string
 */
- (NSString *)decimal2Hex:(NSInteger)decimal;

/**
 *  convert hex string to decimal value
 *
 *  @param binary binary string
 *
 *  @return decimal value
 */
- (NSInteger)hex2Decimal:(NSString *)binary;


/**
 *  bitwise AND operation
 *
 *  @param aNumber NSNumber inner with integer value
 *  @param bNumber NSNumber inner with integer value
 *
 *  @return binary result string
 */
- (NSString *)and_bit:(NSNumber *)aNumber with:(NSNumber *)bNumber;

/**
 *  bitwise OR operation
 *
 *  @param aNumber NSNumber inner with integer value
 *  @param bNumber NSNumber inner with integer value
 *
 *  @return binary result string
 */
- (NSString *)or_bit:(NSNumber *)aNumber with:(NSNumber *)bNumber;

/**
 *  bitwise XOR operation
 *
 *  @param aNumber NSNumber inner with integer value
 *  @param bNumber NSNumber inner with integer value
 *
 *  @return binary result string
 */
- (NSString *)xor_bit:(NSNumber *)aNumber with:(NSNumber *)bNumber;

/**
 *  bitwise left shift
 *
 *  @param value NSNumber inner with integer value
 *  @param step  NSNumber inner with integer value to shift
 *
 *  @return binary result string
 */
- (NSString *)leftShift_bit:(NSNumber *)value by:(NSNumber *)step;

/**
 *  bitwise right shift
 *
 *  @param value NSNumber inner with integer value
 *  @param step  NSNumber inner with integer value to shift
 *
 *  @return binary result string
 */
- (NSString *)rightShift_bit:(NSNumber *)value by:(NSNumber *)step;


/**
 *  reverse bit
 *
 *  @param value NSNumber inner with integer value
 *
 *  @return binary result string
 */
- (NSString *)reverse_bit:(NSNumber *)value;

/**
 *  antitone bit sequence
 *
 *  @param value NSNumber inner with integer value
 *
 *  @return binary result string
 */
- (NSString *)antitone_bit:(NSNumber *)value;

/**
 *  flip 4bit by 4bit
 *
 *  @param value NSNumber inner with integer value
 *
 *  @return binary result string
 */
- (NSString *)flip_4Bit:(NSNumber *)value;

/**
 *  flip 8bit by 8bit
 *
 *  @param value NSNumber inner with integer value
 *
 *  @return binary result string
 */
- (NSString *)flip_8Bit:(NSNumber *)value;

/**
 * used for otp
 */
- (NSUInteger)multiHexToDec:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
