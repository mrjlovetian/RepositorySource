//
//  YHJViewController.m
//  RepositorySource
//
//  Created by mrjlovetian@gmail.com on 08/23/2017.
//  Copyright (c) 2017 mrjlovetian@gmail.com. All rights reserved.
//

#import "YHJViewController.h"
#import "YHJView.h"

@interface YHJViewController ()

@end

@implementation YHJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    YHJView *yhjView = [[YHJView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    yhjView.backgroundColor = [UIColor redColor];
    [self.view addSubview:yhjView];
    
    UIImageView *bView = [[UIImageView alloc] initWithFrame:yhjView.bounds];
    bView.image = [UIImage imageNamed:@"x"];
    [self.view addSubview:bView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
