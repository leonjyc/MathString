//
//  SIFOFolder.h
//  SIFOFileFolder
//
//  Created by Leon on 2019/6/24.
//  Copyright © 2019 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIFOFolder : NSObject

/**
 是否是目录

 @param path 路径
 @return BOOL
 */
+ (BOOL)isDir:(NSString *)path;

/**
 展示所有的文件路径, 包含子目录

 @param path 目录
 @return 数组（文件路径）
 */
+ (NSArray *)listAllFilepathsAtPath:(NSString *)path;

/**
 展示所有的文件路径, 自选是否包含子目录
 
 @param path 目录
 @return 数组（文件路径）
 */
+ (NSArray *)listAllFilepathsAtPath:(NSString *)path showSubPaths:(BOOL)showSub;

/**
 展示所有的文件名, 包含子目录
 
 @param path 目录
 @return 数组（文件名）
 */
+ (NSArray *)listAllFilenamesAtPath:(NSString *)path;

/**
 展示所有的文件名, 自选是否包含子目录
 
 @param path 目录
 @return 数组（文件名）
 */
+ (NSArray *)listAllFilenamesAtPath:(NSString *)path showSubPaths:(BOOL)showSub;

/**
 展示所有的子目录, 自选是否包含子目录
 
 @param path 目录
 @return 数组（目录路径）
 */
+ (NSArray *)listAllSubPathAtPath:(NSString *)path showSubPaths:(BOOL)showSub;


/**
 创建目录

 @param path 路径
 */
+ (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError * _Nullable )error;


/**
 拷贝目录文件
 遍历目录结构
 @param copyPath 拷贝目录
 @param toPath 拷贝至目录
 @param keepFiles 保留源文件
 @return 返回结果
 */
+ (BOOL)copyFolderPath:(nonnull NSString *)copyPath toFolderPath:(nonnull NSString *)toPath keepFiles:(BOOL)keepFiles;

/**
 移动目录文件
 遍历目录结构
 @param movePath 移动目录
 @param toPath 移动至目录
 @param keepFiles 保留源文件
 @return 返回结果
 */
+ (BOOL)moveFolderPath:(nonnull NSString *)movePath toFolderPath:(nonnull NSString *)toPath keepFiles:(BOOL)keepFiles;
@end

NS_ASSUME_NONNULL_END
