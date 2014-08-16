//
//  ImageReflectionView.h
//  ImageReflectionView
//
//  Created by Maitrayee Ghosh on 15/08/14.
//  Copyright (c) 2014 Maitrayee Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageReflectionView : UIView
@property (strong,nonatomic) UIImageView *originalImageView;
@property (strong,nonatomic) UIImageView *reflectedImageView;
-(void)setImageViewForImageDisplay:(UIImage *)image;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *reflectionViewHeightConstraint;
@end
