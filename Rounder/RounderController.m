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

- (IBAction)loadSourceImage:(id)sender
{
    NSImage *source = [sourceImage image];
    NSImage *target = [NSImage alloc];
    NSSize size = [source size];
    
    float width = 660;
    float height = size.height / size.width * width;
    float radius = 100;
    
    
    target = [target initWithSize:NSMakeSize(width, height)];

    [target lockFocus];
    
    NSBezierPath *clipPath = [NSBezierPath bezierPath];    
    
    [clipPath appendBezierPathWithOvalInRect:NSMakeRect(0, 0, radius,  radius)];
    [clipPath appendBezierPathWithOvalInRect:NSMakeRect(0, height-radius, radius, radius)];
    [clipPath appendBezierPathWithOvalInRect:NSMakeRect(width-radius, 0, radius, radius)];
    [clipPath appendBezierPathWithOvalInRect:NSMakeRect(width, height, -radius, -radius)];
    [clipPath appendBezierPathWithRect:NSMakeRect(0, radius/2, width, height-radius)];    
    [clipPath appendBezierPathWithRect:NSMakeRect(radius/2, 0, width-radius, height)];    

    [clipPath addClip];
    
    [source drawInRect:NSMakeRect(0, 0, width, height)
            fromRect:NSMakeRect(0, 0, size.width, size.height)
            operation:NSCompositeCopy
            fraction:1.0];

    [target unlockFocus];
    
    NSBitmapImageRep *targetBitmap = [[NSBitmapImageRep alloc] initWithData:[target TIFFRepresentation]];
    NSData *jpeg = [targetBitmap representationUsingType:NSJPEGFileType properties:nil];
    
    [jpeg writeToFile:@"/Users/mixael/Desktop/2.jpg" atomically:YES];
    [sourceImage setImage:target];
    
    [target release];
    [targetBitmap release];
}

@end
