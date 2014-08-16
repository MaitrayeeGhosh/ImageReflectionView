ImageReflectionView
===================

The ImageReflectionView can be used for creating the reflection of an image.

Feature:
        Create reflection of an image 

System Requirements:
                     Need iOS 7.0 or higher.

Usage:
         
      Use following code to create reflection of an image. Just set the frame of the ImageReflectionView and call the 
      setImageViewForImageDisplay function. It will show the original image with it’s reflection.
      
    UIImage *mainImage=[UIImage imageNamed:@"sampleImage.jpg"];
    ImageReflectionView *reflectionView=[[ImageReflectionView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height)];
    [reflectionView setImageViewForImageDisplay:mainImage];
    [self.view addSubview:reflectionView];

The ImageReflectionView has clear color background , so The reflected image will beautifully show a shadow of 
the background colour of the superview.
