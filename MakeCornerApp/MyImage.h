//
//  Image.h
//  Rounder
//
//  Created by Mikhail B. Petrov on 14.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyImage : NSObject {
@private
    NSImage *source;
    NSImage *target;
    NSString *sourcePath;
    
}
@property (assign, readwrite) NSImage *source;
@property (readonly) NSImage *target; 
@property (assign, readwrite) NSString *sourcePath;

- (id)initWithImage: (NSImage *) sourceImage;
- (void)resize: (float) width radius: (float) radius color: (NSColor *) color;
- (void) saveTo: (NSString*) path;

@end
