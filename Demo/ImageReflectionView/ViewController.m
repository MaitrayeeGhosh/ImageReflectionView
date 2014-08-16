//
//  ViewController.m
//  ImageReflectionView
//
//  Created by Maitrayee Ghosh on 15/08/14.
//  Copyright (c) 2014 Maitrayee Ghosh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *mainImage=[UIImage imageNamed:@"sampleImage.jpg"];
    ImageReflectionView *reflectionView=[[ImageReflectionView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height)];
    [reflectionView setImageViewForImageDisplay:mainImage];
    [self.view addSubview:reflectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
