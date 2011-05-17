//
//  RounderController.m
//  Rounder
//
//  Created by Mikhail B. Petrov on 09.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MakeCornerController.h"
#import "MyImage.h"

NSString* getTargetPath(NSString* sourcePath) {
    /*
        /1/2/3.jpg -> /1/2/3_sexy.jpg
    */
    NSString *targetPath = [[NSString alloc] init];
    NSArray *path = [sourcePath pathComponents];
    NSString *fileName = [path objectAtIndex:([path count] - 1)];
    fileName = [[fileName componentsSeparatedByString:
                 [@"." stringByAppendingString:[fileName pathExtension]]] objectAtIndex:0];
    for (int i = 0; i < ([path count] - 1); i++) {
        targetPath = [targetPath stringByAppendingPathComponent:[path objectAtIndex:i]];
    }
    targetPath = [targetPath stringByAppendingPathComponent:[fileName stringByAppendingString:@"_sexy.jpg"]];
    return targetPath;
}

@implementation MakeCornerController

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
    MyImage *image = [MyImage alloc];
    
    // Читаем параметры из UI
    float width = [widthField floatValue];
    float radius = [radiusField floatValue];
    NSColor *color = [colorField color];
    NSImage *source = [sourceImage image];
    
    image = [image initWithImage: source];
    
    [image resize:width radius:radius color:color];
    
    
    NSString *path = getTargetPath([sourceImage imagePath]);
    [image saveTo:path];
    
    [sourceImage setImage:[image target]];
    
    [image release];
//    [path release];
}

@end
