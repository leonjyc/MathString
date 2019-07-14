//
//  SIFOFile.h
//  SIFOFileFolder
//
//  Created by Leon on 2019/6/24.
//  Copyright © 2019 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIFOFile : NSObject

/**
 拷贝文件

 @param copyPath 路径
 @param toPath 路径
 @param keepFile 保留源文件 将不做拷贝
 @return 结果
 */
+ (BOOL)copyItemAtPath:(nonnull NSString *)copyPath toPath:(nonnull NSString *)toPath keepFile:(BOOL)keepFile;


/**
 移动文件

 @param movePath 路径
 @param toPath 路径
 @param keepFile 保留源文件 将不做复制
 @return 结果
 */
+ (BOOL)moveItemAtPath:(nonnull NSString *)movePath toPath:(nonnull NSString *)toPath keepFile:(BOOL)keepFile;
@end

NS_ASSUME_NONNULL_END
