//
//  main.m
//  MakeCornerCLI
//
//  Created by Mikhail B. Petrov on 18.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

int main (int argc, char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSLog(@"makecorner");
    
    NSMutableDictionary *argsDict = [[[NSMutableDictionary alloc] init] autorelease];
    
    char *widthArg = "660";
    char *radiusArg = "10";
    char *colorArg = "#ffffff";
    int index;
    int c;
    
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
                NSLog(@"Unknown option `-%c'.\n", optopt);
            else
                NSLog(@"Unknown option character `\\x%x'.\n", optopt);
            
            return 1;
        default:
            abort ();
    }
    
    for (index = optind; index < argc; index++)
        NSLog(@"Non-option argument %s\n", argv[index]);
    
    NSLog(@"width = %s, radius = %s, color = %s\n", widthArg, radiusArg, colorArg);
    
    NSString *width = [[[NSString alloc] initWithCString:widthArg encoding:NSUTF8StringEncoding] autorelease];
    NSString *radius = [[[NSString alloc] initWithCString:widthArg encoding:NSUTF8StringEncoding] autorelease];
    NSString *color = [[[NSString alloc] initWithCString:widthArg encoding:NSUTF8StringEncoding] autorelease];
    
    
    [argsDict setValue:width forKey:@"width"];
    [argsDict setValue:radius forKey:@"radius"];
    [argsDict setValue:color forKey:@"color"];
    
    [pool drain];
    return 0;
}

