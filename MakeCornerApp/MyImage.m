//
//  Image.m
//  Rounder
//
//  Created by Mikhail B. Petrov on 14.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import "MyImage.h"


@implementation MyImage
@synthesize source, target, sourcePath;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithImage: (NSImage *) sourceImage
{
    self = [self init];
    source = sourceImage;
    target = [NSImage alloc];
    return self;
}

- (id)initWithContentOfFile: (NSString *) file
{
    self = [self init];
    NSImage *sourceImage = [[[NSImage alloc] initWithContentsOfFile:file] autorelease];
    source = sourceImage;
    target = [NSImage alloc];
    return self;

    
    return [self initWithImage:sourceImage];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)resize: (float) width radius: (float) radius color: (NSColor *) color
{
    NSSize size = [source size];
    
    float height = size.height / size.width * width;
    
//    radius = radius * size.width / width / 2;
    
    target = [target initWithSize:NSMakeSize(width, height)];
    
    [target lockFocus];
    
    
    // Fill a background
    [color set];
    NSRect background = NSMakeRect(0, 0, width, height);
    NSRectFill(background);
    
    
    // Create a clipping mask
    NSBezierPath *clipPath = [NSBezierPath bezierPath];    
    
    [clipPath appendBezierPathWithOvalInRect:NSMakeRect(0, 0, radius,  radius)];
    [clipPath appendBezierPathWithOvalInRect:NSMakeRect(0, height-radius, radius, radius)];
    [clipPath appendBezierPathWithOvalInRect:NSMakeRect(width-radius, 0, radius, radius)];
    [clipPath appendBezierPathWithOvalInRect:NSMakeRect(width, height, -radius, -radius)];
    [clipPath appendBezierPathWithRect:NSMakeRect(0, radius/2, width, height-radius)];    
    [clipPath appendBezierPathWithRect:NSMakeRect(radius/2, 0, width-radius, height)];
    
    [clipPath addClip];
    
    
    // Copy image from source
    [source drawInRect:NSMakeRect(0, 0, width, height)
              fromRect:NSMakeRect(0, 0, size.width, size.height)
             operation:NSCompositeCopy
              fraction:1.0];
    
    [target unlockFocus];
}

- (void) saveTo: (NSString*) path
{
    NSBitmapImageRep *targetBitmap = [[NSBitmapImageRep alloc] initWithData:[target TIFFRepresentation]];
    NSData *jpeg = [targetBitmap representationUsingType:NSJPEGFileType properties:nil];
    
    [jpeg writeToFile:path atomically:YES];
    
    [targetBitmap release];
}
@end
