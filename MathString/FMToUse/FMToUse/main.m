//
//  main.m
//  FMToUse
//
//  Created by Leon on 2019/6/24.
//  Copyright © 2019 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SIFOMathString/SIFOMathString.h>
#import <SIFOFileFolder/SIFOFileFolder.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NSString *str = @"#今日要闻#[偷笑] http://asd.fdfs.2ee/aas/1e @sdf[test] #你确定#@rain李23: @张三[挖鼻屎]m123m";
//        NSString *emopattern = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]";
//        NSLog(@"%@", [SIFOString preg_match:str andPattern:emopattern]);
//        NSLog(@"%@", [SIFOString preg_match_all:str andPattern:emopattern]);
//        NSLog(@"%@", [SIFOString preg_replace:str andPattern:emopattern andReplacement:@"(aaa)"]);
//        NSLog(@"%@", [SIFOString preg_replace_all:str andPattern:emopattern andReplacement:@"(aaa)"]);
//        NSLog(@"%@", [SIFOString macAddress]);
        
//        NSLog(@"%@", [SIFOFolder listAllFilepathsAtPath:@"/Library/LaunchAgents" showSubPaths:YES]);
//        NSLog(@"%@", [SIFOFolder listAllFilenamesAtPath:@"/Library/LaunchAgents" showSubPaths:NO]);
//        NSLog(@"%@", [SIFOFolder listAllSubPathAtPath:@"/Library/LaunchAgents" showSubPaths:YES]);
//        [SIFOFolder createDirectoryAtPath:@"/Library/LaunchAgents/Leon/JYC" error:nil];
//        [SIFOFolder copyFolderPath:@"/AppleInternal/FixtureService/Leon/" toFolderPath:@"/AppleInternal/FixtureService/Leon1/" keepFiles:NO];
//        [SIFOFolder moveFolderPath:@"/AppleInternal/FixtureService/Leon2/" toFolderPath:@"/AppleInternal/FixtureService/Leon/" keepFiles:NO];
        [SIFOFile copyItemAtPath:@"/AppleInternal/FixtureService/Leon4/J780SiFoFixtureService.xpc.zip" toPath:@"/AppleInternal/FixtureService/Leon5/J780SiFoFixtureService.xpc.zip" keepFile:YES];
        [SIFOFile moveItemAtPath:@"/AppleInternal/FixtureService/Leon5/J780SiFoFixtureService.xpc.zip" toPath:@"/AppleInternal/FixtureService/Leon4/J780SiFoFixtureService.xpc.zip" keepFile:NO];
    }
    return 0;
}
