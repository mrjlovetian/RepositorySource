//
//  YHJView.m
//  Pods
//
//  Created by Mr on 2017/8/23.
//
//

#import "YHJView.h"

#import "NSBundle+FindBundle.h"

@implementation YHJView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    ///s.resources访问资源
//    imageView.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"x" ofType:@"png"]];
    imageView.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle getFrameWork] pathForResource:@"aa" ofType:@"png"]];
    
    
    ///s.resource_bundles访问资源
//    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle getFrameWork] pathForResource:@"Soruce" ofType:@"bundle"]];
//    imageView.image = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"aa" ofType:@"png"]];
//    imageView.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle getFrameWork] pathForResource:@"x" ofType:@"png"]];

    imageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:imageView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
