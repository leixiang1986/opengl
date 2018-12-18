//
//  ViewController.m
//  HelloOpenGL
//
//  Created by mac on 2018/12/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "LXOpenglColorView.h"
#import "LXOpenGLColorLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    LXOpenGLColorLayer *layer = [LXOpenGLColorLayer layer];
    
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
//    layer.backgroundColor = [UIColor yellowColor].CGColor;
}


@end
