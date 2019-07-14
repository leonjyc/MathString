//
//  SIFOFile.m
//  SIFOFileFolder
//
//  Created by Leon on 2019/6/24.
//  Copyright © 2019 Leon. All rights reserved.
//

#import "SIFOFile.h"
#import "SIFOFolder.h"
@implementation SIFOFile
+ (BOOL)copyItemAtPath:(nonnull NSString *)copyPath toPath:(nonnull NSString *)toPath keepFile:(BOOL)keepFile{
    if (![[NSFileManager defaultManager] fileExistsAtPath:copyPath]) {
        NSLog(@"no file exists : %@", copyPath);
        return NO;
    }
    if (keepFile == NO) {
        NSLog(@"need remove %@", toPath);
        [[NSFileManager defaultManager] removeItemAtPath:toPath error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
        NSLog(@"file exists");
        return NO;
    }
    NSMutableArray *folderArr = [NSMutableArray arrayWithArray:[toPath componentsSeparatedByString:@"/"]];
    [folderArr removeLastObject];
    NSString *toFolder = [folderArr componentsJoinedByString:@"/"];
    if (![SIFOFolder isDir:toFolder]) {
        NSLog(@"create folder %@", toFolder);
        [SIFOFolder createDirectoryAtPath:toFolder error:nil];
    }
    [[NSFileManager defaultManager] copyItemAtPath:copyPath toPath:toPath error:nil];
    return YES;
}

+ (BOOL)moveItemAtPath:(nonnull NSString *)movePath toPath:(nonnull NSString *)toPath keepFile:(BOOL)keepFile{
    if (![[NSFileManager defaultManager] fileExistsAtPath:movePath]) {
        NSLog(@"no file exists : %@", movePath);
        return NO;
    }
    if (keepFile == NO) {
        NSLog(@"need remove %@", toPath);
        [[NSFileManager defaultManager] removeItemAtPath:toPath error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
        NSLog(@"file exists");
        return NO;
    }
    NSMutableArray *folderArr = [NSMutableArray arrayWithArray:[toPath componentsSeparatedByString:@"/"]];
    [folderArr removeLastObject];
    NSString *toFolder = [folderArr componentsJoinedByString:@"/"];
    if (![SIFOFolder isDir:toFolder]) {
        NSLog(@"create folder %@", toFolder);
        [SIFOFolder createDirectoryAtPath:toFolder error:nil];
    }
    [[NSFileManager defaultManager] moveItemAtPath:movePath toPath:toPath error:nil];
    return YES;
}
@end
