//
//  NSBundle+FindBundle.m
//  Pods
//
//  Created by Mr on 2017/8/23.
//
//

#import "NSBundle+FindBundle.h"
#import "YHJView.h"

@implementation NSBundle (FindBundle)
+ (NSBundle *)getFrameWork
{
    return [NSBundle bundleWithURL:[self getFramerUrl]];
}

+ (NSURL *)getFramerUrl
{
    NSBundle *bundel = [NSBundle bundleForClass:[YHJView class]];
    return [bundel URLForResource:@"Soruce" withExtension:@"bundle"];
}


@end
