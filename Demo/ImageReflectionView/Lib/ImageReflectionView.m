//
//  ImageReflectionView.m
//  ImageReflectionView
//
//  Created by Maitrayee Ghosh on 15/08/14.
//  Copyright (c) 2014 Maitrayee Ghosh. All rights reserved.
//

#import "ImageReflectionView.h"

@implementation ImageReflectionView
static const CGFloat kDefaultReflectionFraction = 0.9;
static const CGFloat kDefaultReflectionOpacity = 0.80;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];

    }
    return self;
}

- (CGSize)getSizeOfOriginalImage:(UIImage *)originalImage
{
    CGSize size=CGSizeMake(originalImage.size.width, originalImage.size.height);
    return size;
}


-(CGSize)setImageViewSizeBasedOnImageSize:(UIImage *)image
{
    CGSize imageSize=[self getSizeOfOriginalImage:image];
   
    CGSize imageViewSize;
    float aspectWidth=((self.bounds.size.height/2)/imageSize.height)*imageSize.width;
    NSLog(@"aspect width %f",aspectWidth);
    if (aspectWidth>=320) {
        aspectWidth=320;
    }
    
    imageViewSize=CGSizeMake(aspectWidth, self.bounds.size.height/2);
   
    return imageViewSize;
    
}

-(CGRect)getImageViewFrameBasedOnImageSize:(UIImage *)image
{
    CGSize imageViewSize=[self setImageViewSizeBasedOnImageSize:image];
     NSLog(@"height %f and width %f",imageViewSize.height,imageViewSize.width);
    float x;
    float y;
    if (imageViewSize.width>=320) {
        x=0;
    }
    else
    {
        x=(320-imageViewSize.width)/2;
    }
    
    if (imageViewSize.height>=self.bounds.size.height/2) {
        y=0;
    }
    else
    {
        y=((self.bounds.size.height)/2)-imageViewSize.height;
    }
    
    return CGRectMake(x, y, imageViewSize.width, imageViewSize.height);
}


-(void)setImageViewForImageDisplay:(UIImage *)image
{
    CGRect imageViewFrame=[self getImageViewFrameBasedOnImageSize:image];
   
    self.originalImageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewFrame.origin.x,0,imageViewFrame.size.width,imageViewFrame.size.height)];
    self.originalImageView.contentMode=UIViewContentModeScaleToFill;
    self.originalImageView.image=image;
    [self addSubview:self.originalImageView];
    
    self.reflectedImageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewFrame.origin.x,self.bounds.size.height/2,imageViewFrame.size.width,imageViewFrame.size.height)];
    self.reflectedImageView.contentMode=UIViewContentModeScaleToFill ;
     int reflectionHeight = self.originalImageView.bounds.size.height * kDefaultReflectionFraction;
    self.reflectedImageView.image = [self reflectedImage:self.originalImageView withHeight:reflectionHeight];
    self.reflectedImageView.alpha = kDefaultReflectionOpacity;
    [self addSubview:self.reflectedImageView];
    
}

#pragma mark - Image Reflection

CGImageRef CreateGradientImage(NSInteger pixelsWide, NSInteger pixelsHigh)
{
    CGImageRef theCGImage = NULL;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();

    CGContextRef gradientBitmapContext = CGBitmapContextCreate(NULL, pixelsWide, pixelsHigh,
                                                               8, 0, colorSpace, kCGImageAlphaNone);
    CGFloat colors[] = {0.0, 1.0, 1.0, 1.0};

    CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    CGColorSpaceRelease(colorSpace);

    CGPoint gradientStartPoint = CGPointZero;
    CGPoint gradientEndPoint = CGPointMake(0, pixelsHigh);

    CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint,
                                gradientEndPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(grayScaleGradient);
 
    theCGImage = CGBitmapContextCreateImage(gradientBitmapContext);
    CGContextRelease(gradientBitmapContext);

    return theCGImage;
}

CGContextRef MyCreateBitmapContext(NSInteger pixelsWide, NSInteger pixelsHigh)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef bitmapContext = CGBitmapContextCreate (NULL, pixelsWide, pixelsHigh, 8,
                                                        0, colorSpace,
                                                        (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGColorSpaceRelease(colorSpace);
    
    return bitmapContext;
}

- (UIImage *)reflectedImage:(UIImageView *)fromImage withHeight:(NSInteger)height
{
    if (height == 0)
        return nil;
   
    CGContextRef mainViewContentContext = MyCreateBitmapContext(fromImage.bounds.size.width, height);
    CGImageRef gradientMaskImage = CreateGradientImage(1, height);
    CGContextClipToMask(mainViewContentContext, CGRectMake(0.0, 0.0, fromImage.bounds.size.width, height), gradientMaskImage);
    CGImageRelease(gradientMaskImage);
    CGContextTranslateCTM(mainViewContentContext, 0.0, height);
    CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);
    
    CGContextDrawImage(mainViewContentContext, fromImage.bounds, fromImage.image.CGImage);
    CGImageRef reflectionImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
   
    UIImage *theImage = [UIImage imageWithCGImage:reflectionImage];
    CGImageRelease(reflectionImage);
    
    return theImage;
}




@end
