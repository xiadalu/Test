//
//  ViewController.m
//  Example
//
//  Created by xiadalu on 2020/6/24.
//  Copyright © 2020 xiadalu. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView* v = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil].lastObject;
    [self.view addSubview:v];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
}


@end
