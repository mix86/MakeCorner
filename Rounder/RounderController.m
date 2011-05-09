//
//  RounderController.m
//  Rounder
//
//  Created by Mikhail B. Petrov on 09.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RounderController.h"


@implementation RounderController

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

//- (IBAction)processImage:(id)sender
//{
//    NSLog(@"AAAA");
//    
//    
//    NSImage *sourceImage;
//    
//    
//    sourceImage = [NSImage alloc];
//    
//    [sourceImage initWithContentsOfFile:@"/Users/mixael/Desktop/1.jpg"];
//    
//    [sourceImage setImage:sourceImage];
//    
//    
//}

- (IBAction)loadSourceImage:(id)sender
{
    NSLog(@"loadImage");
    
    float targetWidth = 100;
    
    NSImage *source = [sourceImage image];
    NSImage *target = [NSImage alloc];    
    NSSize size = [source size];
    
    
    NSLog(@"Source: width=%f, height=%f", size.width, size.height);
    
    float targetHeight = size.height / size.width * targetWidth;
    
    NSLog(@"Source: width=%f, height=%f", targetWidth, targetHeight);

    
    [target initWithSize:NSMakeSize(targetWidth, targetHeight)];
    
    
    [target lockFocus];
    
    [source drawInRect:NSMakeRect(0, 0, targetWidth, targetHeight)
            fromRect:NSMakeRect(0, 0, size.width, size.height)
            operation:NSCompositeCopy
            fraction:1.0];
    [target unlockFocus];

    
    
    NSData *targetData = [target TIFFRepresentation];
    
    NSBitmapImageRep *targetRep = [[NSBitmapImageRep alloc] initWithData:targetData];
    
    NSData *saveData = [targetRep representationUsingType:NSJPEGFileType properties:nil];

    [saveData writeToFile:@"/Users/mixael/Desktop/2.jpg" atomically:YES];

    
}

@end
