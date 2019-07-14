//
//  SIFOMath.m
//  SIFOMathString
//
//  Created by Leon on 2019/6/24.
//  Copyright © 2019 Leon. All rights reserved.
//

#import "SIFOMath.h"

@implementation SIFOMath
+ (NSString *)hexToBinary:(NSString *)hex {
    NSString *hexStr = [[hex stringByReplacingOccurrencesOfString:@"0x" withString:@""] uppercaseString];
    NSMutableDictionary  *hexDic = [[NSMutableDictionary alloc] init];
    
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    NSMutableString *binaryString=[[NSMutableString alloc] init];
    
    for (int i=0; i<[hexStr length]; i++) {
        NSRange rage;
        rage.length = 1;
        rage.location = i;
        NSString *key = [hexStr substringWithRange:rage];
        binaryString = (NSMutableString *)[NSString stringWithFormat:@"%@%@",binaryString,[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
    }
    return binaryString;
}

+ (NSString *)binaryToHex:(NSString *)binary {
    char *cstr = (char *)[binary cStringUsingEncoding: NSASCIIStringEncoding];
    
    NSUInteger len = strlen(cstr);
    
    char *lastChar = cstr + len - 1;
    NSUInteger curVal = 1;
    
    NSUInteger result = 0;
    
    while (lastChar >= cstr) {
        
        if (*lastChar == '1') {
            result += curVal;
        }
        
        lastChar--;
        curVal <<= 1;
    }
    
    NSString *resultStr = [NSString stringWithFormat: @"%lx", (unsigned long)result];
    return resultStr;
}

+ (NSString *)decimalToBinary:(uint16_t)tmpid backLength:(int)length
{
    NSString *tmpStr = @"";
    while (tmpid)
    {
        tmpStr = [[NSString stringWithFormat:@"%d",tmpid%2] stringByAppendingString:tmpStr];
        if (tmpid/2 < 1)
        {
            break;
        }
        tmpid = tmpid/2 ;
    }
    
    if (tmpStr.length <= length)
    {
        NSMutableString *mutableTmpStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < length - tmpStr.length; i++)
        {
            [mutableTmpStr appendString:@"0"];
        }
        
        tmpStr = [mutableTmpStr stringByAppendingString:tmpStr];
    }
    return tmpStr;
}

+(int)hexToDecimal:(NSString *)hexString
{
    unsigned int outVal;
    NSScanner* scanner = [NSScanner scannerWithString:hexString]; //0x is optional
    [scanner scanHexInt:&outVal];
    return outVal;
}

+(NSString *)decimalToHex:(int)value withLength:(int)length
{
    
    NSString *hex_i = [NSString stringWithFormat:@"%X", value];
    int z = (int)(length - hex_i.length);
    if (length <= hex_i.length) {
        hex_i = [hex_i substringFromIndex:(hex_i.length - length)];
    }else{
        for (int k = 0; k < z; k++) {
            hex_i = [NSString stringWithFormat:@"%d%@",0,hex_i];
        }
    }
    return hex_i;
}

+ (NSString *) dataToHex:(NSData *)data lcation:(int)location length:(int)length
{
    if (data && data.length > length) {
        
        NSString *str = [NSString stringWithFormat:@"%@",[data subdataWithRange:NSMakeRange(location, length)]];
        return [str substringWithRange:NSMakeRange(1, str.length-2)];
    }else{
        return @"Error";
    }
}

+ (NSString *)littleEndianToBigEndian:(NSString *)string {
    NSMutableString *bigEndianString = [NSMutableString new];
    
    bool setLeadingZero = [string length] % 2;
    
    for (NSInteger pos = [string length]; pos > 0; pos -= 2) {
        if (pos <= 2 && setLeadingZero) {
            [bigEndianString appendString:@"0"];
            [bigEndianString appendString:[string substringWithRange:NSMakeRange(pos - 1, 1)]];
        }
        else{
            [bigEndianString appendString:[string substringWithRange:NSMakeRange(pos - 2, 2)]];
        }
    }
    
    return bigEndianString;
}

// hex string convert digital number

+ (NSNumber *) numberHexString:(NSString *)aHexString

{
    if (nil == aHexString)
    {
        return nil;
    }
    
    NSScanner * scanner = [NSScanner scannerWithString:aHexString];
    unsigned long long longlongValue;
    [scanner scanHexLongLong:&longlongValue];
    NSNumber * hexNumber = [NSNumber numberWithLongLong:longlongValue];
    return hexNumber;
}

- (NSString *)hex2Binary:(NSString *)hex
{
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSString *binary = @"";
    
    for (int i = [hex.uppercaseString hasPrefix:@"0X"] ? 2 : 0; i<hex.length; i++) {
        
        NSString *key = [hex substringWithRange:NSMakeRange(i, 1)];
        NSString *value = [hexDic objectForKey:key.uppercaseString];
        if (value) {
            binary = [binary stringByAppendingString:value];
        }
        else
        {
            return @"hex format error";
        }
    }
    return binary;
}


- (NSString *)binary2Hex:(NSString *)binary
{
    NSMutableDictionary *binaryDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [binaryDic setObject:@"0" forKey:@"0000"];
    [binaryDic setObject:@"1" forKey:@"0001"];
    [binaryDic setObject:@"2" forKey:@"0010"];
    [binaryDic setObject:@"3" forKey:@"0011"];
    [binaryDic setObject:@"4" forKey:@"0100"];
    [binaryDic setObject:@"5" forKey:@"0101"];
    [binaryDic setObject:@"6" forKey:@"0110"];
    [binaryDic setObject:@"7" forKey:@"0111"];
    [binaryDic setObject:@"8" forKey:@"1000"];
    [binaryDic setObject:@"9" forKey:@"1001"];
    [binaryDic setObject:@"A" forKey:@"1010"];
    [binaryDic setObject:@"B" forKey:@"1011"];
    [binaryDic setObject:@"C" forKey:@"1100"];
    [binaryDic setObject:@"D" forKey:@"1101"];
    [binaryDic setObject:@"E" forKey:@"1110"];
    [binaryDic setObject:@"F" forKey:@"1111"];
    
    if (binary.length % 4 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    NSString *hex = @"";
    for (int i=0; i<binary.length; i+=4) {
        
        NSString *key = [binary substringWithRange:NSMakeRange(i, 4)];
        NSString *value = [binaryDic objectForKey:key];
        if (value) {
            
            hex = [hex stringByAppendingString:value];
        }
    }
    return hex;
}


- (NSString *)decimal2Binary:(NSInteger)decimal
{
    if (decimal == 0) return @"0";
    NSString *binary = @"";
    while (decimal) {
        
        binary = [[NSString stringWithFormat:@"%ld", decimal % 2] stringByAppendingString:binary];
        if (decimal / 2 < 1) {
            
            break;
        }
        decimal = decimal / 2 ;
    }
    if (binary.length % 4 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    return binary;
}


- (NSInteger)binary2Decimal:(NSString *)binary
{
    NSInteger decimal = 0;
    for (int i=0; i<binary.length; i++) {
        
        NSString *number = [binary substringWithRange:NSMakeRange(binary.length - i - 1, 1)];
        if ([number isEqualToString:@"1"]) {
            
            decimal += pow(2, i);
        }
    }
    return decimal;
}

- (NSString *)decimal2Hex:(NSInteger)decimal
{
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            break;
        }
    }
    
    if([hex length] == 1){
        hex = [NSString stringWithFormat:@"0%@",hex];
    }
    
    return hex;
}

- (NSInteger)hex2Decimal:(NSString *)hex
{
    NSInteger decimal = 0;
    
    NSString *binary = [self hex2Binary:hex];
    decimal = [self binary2Decimal:binary];
    
    return decimal;
}

- (NSString *)or_bit:(NSNumber *)aNumber with:(NSNumber *)bNumber
{
    NSString *result = @"";
    
    if(!aNumber || !bNumber) return result;
    
    NSExpression *expression1 = [NSExpression expressionForConstantValue: aNumber];
    NSExpression *expression2 = [NSExpression expressionForConstantValue: bNumber];
    
    NSString *functionName = @"bitwiseOr:with:";
    NSExpression* expression = [NSExpression expressionForFunction:functionName arguments:@[expression1, expression2]];
    NSInteger or_result = [[expression expressionValueWithObject: nil context: nil] integerValue];
    
    result = [self decimal2Hex:or_result];
    
    return result;
}

- (NSString *)and_bit:(NSNumber *)aNumber with:(NSNumber *)bNumber
{
    NSString *result = @"";
    
    if(!aNumber || !bNumber) return result;
    
    NSExpression *expression1 = [NSExpression expressionForConstantValue: aNumber];
    NSExpression *expression2 = [NSExpression expressionForConstantValue: bNumber];
    
    NSExpression* expression = [NSExpression expressionForFunction:@"bitwiseAnd:with:" arguments:@[expression1, expression2]];
    NSInteger or_result = [[expression expressionValueWithObject: nil context: nil] integerValue];
    
    result = [self decimal2Hex:or_result];
    
    return result;
}

- (NSString *)xor_bit:(NSNumber *)aNumber with:(NSNumber *)bNumber
{
    NSString *result = @"";
    
    if(!aNumber || !bNumber) return result;
    
    NSExpression *expression1 = [NSExpression expressionForConstantValue: aNumber];
    NSExpression *expression2 = [NSExpression expressionForConstantValue: bNumber];
    
    NSExpression* expression = [NSExpression expressionForFunction:@"bitwiseXor:with:" arguments:@[expression1, expression2]];
    NSInteger or_result = [[expression expressionValueWithObject: nil context: nil] integerValue];
    
    result = [self decimal2Hex:or_result];
    
    return result;
}

- (NSString *)leftShift_bit:(NSNumber *)value by:(NSNumber *)step
{
    NSString *result = @"";
    
    NSExpression *expression1 = [NSExpression expressionForConstantValue: value];
    NSExpression *expression2 = [NSExpression expressionForConstantValue: step];
    
    NSExpression* expression = [NSExpression expressionForFunction:@"leftshift:by:" arguments:@[expression1, expression2]];
    NSInteger or_result = [[expression expressionValueWithObject: nil context: nil] integerValue];
    
    result = [self decimal2Binary:or_result];
    
    return result;
}


- (NSString *)rightShift_bit:(NSNumber *)value by:(NSNumber *)step
{
    NSString *result = @"";
    
    NSExpression *expression1 = [NSExpression expressionForConstantValue: value];
    NSExpression *expression2 = [NSExpression expressionForConstantValue: step];
    
    NSExpression* expression = [NSExpression expressionForFunction:@"rightshift:by:" arguments:@[expression1, expression2]];
    NSInteger or_result = [[expression expressionValueWithObject: nil context: nil] integerValue];
    
    result = [self decimal2Binary:or_result];
    
    return result;
}


- (NSString *)reverse_bit:(NSNumber *)value
{
    NSString *result = @"";
    
    result = [self decimal2Binary:[value integerValue]];
    result = [result stringByReplacingOccurrencesOfString:@"0" withString:@"2"];
    result = [result stringByReplacingOccurrencesOfString:@"1" withString:@"0"];
    result = [result stringByReplacingOccurrencesOfString:@"2" withString:@"1"];
    
    return result;
}


- (NSString *)antitone_bit:(NSNumber *)value
{
    NSString *result = @"";
    NSString *aString = [self decimal2Binary:[value integerValue]];
    const char* charString = [aString UTF8String];
    int iLenth = (int)strlen(charString);
    for (int i = 0 ; i < iLenth; i++) {
        result = [NSString stringWithFormat:@"%c%@", charString[i], result];
    }
    
    return result;
}


- (NSString *)flip_4Bit:(NSNumber *)value
{
    NSString *result = @"";
    
    NSString *binary = [self decimal2Binary:[value integerValue]];
    
    if (binary.length % 8 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 8 - binary.length % 8; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    
    int iLenth = (int)binary.length/8;
    for (int i = 0; i < iLenth; i++) {
        NSString *hi4 = [binary substringWithRange:NSMakeRange(i*8, 4)];
        NSString *lo4 = [binary substringWithRange:NSMakeRange(i*8+4, 4)];
        result = [NSString stringWithFormat:@"%@%@%@", result, lo4, hi4];
    }
    
    return result;
}


- (NSString *)flip_8Bit:(NSNumber *)value
{
    NSString *result = @"";
    
    NSString *binary = [self decimal2Binary:[value integerValue]];
    
    if (binary.length % 16 != 0) {
        
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 16 - binary.length % 16; i++) {
            
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    
    int iLenth = (int)binary.length/16;
    for (int i = 0; i < iLenth; i++) {
        NSString *hi4 = [binary substringWithRange:NSMakeRange(i*16, 8)];
        NSString *lo4 = [binary substringWithRange:NSMakeRange(i*16+8, 8)];
        result = [NSString stringWithFormat:@"%@%@%@", result, lo4, hi4];
    }
    
    return result;
}

- (NSUInteger)multiHexToDec:(NSString *)hexString{
    NSUInteger length = hexString.length;
    NSUInteger part = length / 2;
    NSUInteger sum = 0;
    for (int i =0; i < part; i++) {
        NSString *str = [hexString substringWithRange:NSMakeRange(i*2, 2)];
        NSUInteger sum0 = [self hex2Decimal:str];
        sum = sum + sum0 * pow(256, (part - i -1));
    }
    return sum;
}

@end
