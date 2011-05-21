//
//  main.m
//  MakeCornerCLI
//
//  Created by Mikhail B. Petrov on 18.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import "MyImage.h"

int parseArgs(char** argv, int argc, NSMutableDictionary *kwargs, NSMutableArray *args) 
{
    char *widthArg = "660";
    char *radiusArg = "10";
    char *colorArg = "#ffffff";
    int index;
    int c;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    opterr = 0;
    
    while ((c = getopt(argc, argv, "w:r:c:")) != -1)
        switch (c)
    {
        case 'w':
            widthArg = optarg;
            break;
        case 'r':
            radiusArg = optarg;
            break;
        case 'c':
            colorArg = optarg;
            break;
        case '?':
            if (isprint (optopt))
                printf("Unknown option `-%c'.\n", optopt);
            else
                printf("Unknown option character `\\x%x'.\n", optopt);
            
            return 1;
        default:
            abort ();
    }
    
    for (index = optind; index < argc; index++) {
        NSString *dir = [[[NSString alloc] initWithCString:argv[index] encoding:NSUTF8StringEncoding] autorelease];
        [args addObject:dir];
    }
    
    NSString *widthStr = [[[NSString alloc] initWithCString:widthArg encoding:NSUTF8StringEncoding] autorelease];
    NSString *radiusStr = [[[NSString alloc] initWithCString:radiusArg encoding:NSUTF8StringEncoding] autorelease];
    NSString *colorStr = [[[NSString alloc] initWithCString:colorArg encoding:NSUTF8StringEncoding] autorelease];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber *width = [formatter numberFromString:widthStr];
    NSNumber *radius = [formatter numberFromString:radiusStr];

    NSColor *color = [NSColor colorWithCalibratedRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    
    [kwargs setValue:width forKey:@"width"];
    [kwargs setValue:radius forKey:@"radius"];
    [kwargs setValue:color forKey:@"color"];

    [formatter release];

    return 0;

}

NSArray* getLitsOfJPGs (NSString *dir)
{
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];
    NSArray *onlyJPGs = [dirContents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.jpg'"]];

    NSMutableArray *fullPaths = [[[NSMutableArray alloc] init] autorelease];
    
    for (int i=0; i < [onlyJPGs count]; i++) {
        NSString *fullPath = [dir stringByAppendingPathComponent:[onlyJPGs objectAtIndex:i]];
        [fullPaths addObject:fullPath];
    }
    
    return fullPaths;
                                                                  
}

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


void processImages(NSArray *images, NSDictionary *kwargs)
{
    for (int i = 0; i < [images count]; i++) {
        NSString *imagePath = [images objectAtIndex:i];
        NSString *targetPath = getTargetPath(imagePath);
        
        MyImage *image = [[MyImage alloc] initWithContentOfFile:imagePath];
        
        
        float width = [[kwargs objectForKey:@"width"] floatValue];
        
        float radius = [[kwargs objectForKey:@"radius"] floatValue];
        
        NSColor *color = [kwargs objectForKey:@"color"];
        
        [image resize:width radius:radius color:color];
        
        [image saveTo:targetPath];
        [image release];
        
    }

}

int main (int argc, char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];    
    NSMutableDictionary *kwargsDict = [[[NSMutableDictionary alloc] init] autorelease];
    NSMutableArray *argsArray = [[[NSMutableArray alloc] init] autorelease];
    NSString *dir = [[[NSString alloc] init] autorelease];
    
    int rc = parseArgs(argv, argc, kwargsDict, argsArray);
    if(!rc)
    {
        dir = [argsArray objectAtIndex:0];
        NSArray *imagesArray = getLitsOfJPGs(dir);
        processImages(imagesArray, kwargsDict);
    }
    
    [pool drain];
    return rc;
}

