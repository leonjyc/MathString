//
//  SIFOFolder.m
//  SIFOFileFolder
//
//  Created by Leon on 2019/6/24.
//  Copyright © 2019 Leon. All rights reserved.
//

#import "SIFOFolder.h"

@implementation SIFOFolder
+ (BOOL)isDir:(NSString *)path{
    BOOL isDir = NO;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if ([path hasSuffix:@".xpc"]) {
        return NO;
    }
    return isDir && isExist;
}

+ (NSArray *)listAllFilepathsAtPath:(NSString *)path{
    return [SIFOFolder listAllFilepathsAtPath:path showSubPaths:YES];
}

+ (NSArray *)listAllFilepathsAtPath:(NSString *)path showSubPaths:(BOOL)showSub{
    if (![SIFOFolder isDir:path]) {
        return nil;
    }
    NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray *filepaths = [NSMutableArray arrayWithCapacity:contentsAtPath.count];
    for (NSString *fileName in contentsAtPath) {
        NSString *filepath = [path stringByAppendingPathComponent:fileName];
        if (showSub) {
            if ([SIFOFolder isDir:filepath]) {
                [filepaths addObjectsFromArray:[SIFOFolder listAllFilepathsAtPath:filepath showSubPaths:showSub]];
            }
            else{
                [filepaths addObject:filepath];
            }
        }else{
            [filepaths addObject:filepath];
        }
    }
    return filepaths;
}

+ (NSArray *)listAllFilenamesAtPath:(NSString *)path{
    if (![SIFOFolder isDir:path]) {
        return nil;
    }
    NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray *filepaths = [NSMutableArray arrayWithCapacity:contentsAtPath.count];
    for (NSString *fileName in contentsAtPath) {
        NSString *filepath = [path stringByAppendingPathComponent:fileName];
        if ([SIFOFolder isDir:filepath]) {
            [filepaths addObjectsFromArray:[SIFOFolder listAllFilenamesAtPath:filepath]];
        }
        else{
            [filepaths addObject:fileName];
        }
    }
    return filepaths;
}

+ (NSArray *)listAllFilenamesAtPath:(NSString *)path showSubPaths:(BOOL)showSub{
    if (![SIFOFolder isDir:path]) {
        return nil;
    }
    NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    if (!showSub) {
        return contentsAtPath;
    }
    NSMutableArray *filepaths = [NSMutableArray arrayWithCapacity:contentsAtPath.count];
    for (NSString *fileName in contentsAtPath) {
        NSString *filepath = [path stringByAppendingPathComponent:fileName];
        if ([SIFOFolder isDir:filepath]) {
            [filepaths addObjectsFromArray:[SIFOFolder listAllFilenamesAtPath:filepath showSubPaths:showSub]];
        }
        else{
            [filepaths addObject:fileName];
        }
    }
    return filepaths;
}

+ (NSArray *)listAllSubPathAtPath:(NSString *)path showSubPaths:(BOOL)showSub{
    if (![SIFOFolder isDir:path]) {
        return nil;
    }
    NSArray *contentsAtPath = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray *filepaths = [NSMutableArray arrayWithCapacity:contentsAtPath.count];
    for (NSString *fileName in contentsAtPath) {
        NSString *filepath = [path stringByAppendingPathComponent:fileName];
        if ([SIFOFolder isDir:filepath]) {
            [filepaths addObject:filepath];
            if (showSub == YES) {
                if ([SIFOFolder isDir:filepath]) {
                    [filepaths addObjectsFromArray:[SIFOFolder listAllSubPathAtPath:filepath showSubPaths:showSub]];
                }
            }
        }
    }
    return filepaths;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError * _Nullable)error{
    if (![SIFOFolder isDir:path]) {
        BOOL isSuccess =  [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"createDirectoryAtPath error ! message: %@",error.userInfo);
        }
        return isSuccess;
    }
    return YES;
}

+ (BOOL)copyFolderPath:(nonnull NSString *)copyPath toFolderPath:(nonnull NSString *)toPath keepFiles:(BOOL)keepFiles{
    if (![SIFOFolder isDir:copyPath]) {
        NSLog(@"copyPath not exists");
        return NO;
    }
    if (![SIFOFolder isDir:toPath]) {
        NSLog(@"if toPath not exists, create first");
        [SIFOFolder createDirectoryAtPath:toPath error:nil];
    }
    NSArray *contentsAtPath = [SIFOFolder listAllFilenamesAtPath:copyPath showSubPaths:NO];
    for (NSString *name in contentsAtPath) {
        NSString *fullPath = [copyPath stringByAppendingPathComponent:name];
        NSString *fullToPath = [toPath stringByAppendingPathComponent:name];
        NSLog(@"fullPath : %@", fullPath);
        NSLog(@"fullToPath : %@", fullToPath);
        if (![[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
            NSLog(@"copyFilePath not exists");
            return NO;
        }
        if ([SIFOFolder isDir:fullPath]) {
            NSLog(@"fullPath is Folder");
            [SIFOFolder copyFolderPath:fullPath toFolderPath:fullToPath keepFiles:keepFiles];
        }
        else{
            if ([[NSFileManager defaultManager] fileExistsAtPath:fullToPath]) {
                if (keepFiles == NO) {
                    NSLog(@"file exists, need remove first");
                    [[NSFileManager defaultManager] removeItemAtPath:fullToPath error:nil];
                    [NSThread sleepForTimeInterval:0.001];
                    NSLog(@"file removed, then copy");
                    [[NSFileManager defaultManager] copyItemAtPath:fullPath toPath:fullToPath error:nil];
                }else{
                    NSLog(@"file exists, need KEEP");
                }
            }else{
                NSLog(@"file not exist, only need copy");
                [[NSFileManager defaultManager] copyItemAtPath:fullPath toPath:fullToPath error:nil];
            }
        }
    }
    return YES;
}

+ (BOOL)moveFolderPath:(nonnull NSString *)movePath toFolderPath:(nonnull NSString *)toPath keepFiles:(BOOL)keepFiles{
    if (![SIFOFolder isDir:movePath]) {
        NSLog(@"movePath not exists");
        return NO;
    }
    if (![SIFOFolder isDir:toPath]) {
        NSLog(@"if toPath not exists, create first");
        [SIFOFolder createDirectoryAtPath:toPath error:nil];
    }
    NSArray *contentsAtPath = [SIFOFolder listAllFilenamesAtPath:movePath showSubPaths:NO];
    for (NSString *name in contentsAtPath) {
        NSString *fullPath = [movePath stringByAppendingPathComponent:name];
        NSString *fullToPath = [toPath stringByAppendingPathComponent:name];
        NSLog(@"fullPath : %@", fullPath);
        NSLog(@"fullToPath : %@", fullToPath);
        if (![[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
            NSLog(@"moveFilePath not exists");
            return NO;
        }
        if ([SIFOFolder isDir:fullPath]) {
            NSLog(@"fullPath is Folder");
            [SIFOFolder moveFolderPath:fullPath toFolderPath:fullToPath keepFiles:keepFiles];
        }
        else{
            if ([[NSFileManager defaultManager] fileExistsAtPath:fullToPath]) {
                if (keepFiles == NO) {
                    NSLog(@"file exists, need remove first");
                    [[NSFileManager defaultManager] removeItemAtPath:fullToPath error:nil];
                    [NSThread sleepForTimeInterval:0.001];
                    NSLog(@"file removed, then move");
                    [[NSFileManager defaultManager] moveItemAtPath:fullPath toPath:fullToPath error:nil];
                }else{
                    NSLog(@"file exists, need KEEP");
                }
            }else{
                NSLog(@"file not exist, only need move");
                [[NSFileManager defaultManager] moveItemAtPath:fullPath toPath:fullToPath error:nil];
            }
        }
    }
    return YES;
}
@end
