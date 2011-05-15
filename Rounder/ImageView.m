//
//  ImageView.m
//  Rounder
//
//  Created by Mikhail B. Petrov on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageView.h"


@implementation ImageView
@synthesize imagePath;
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

-(void)concludeDragOperation:(id <NSDraggingInfo>)sender {
    NSPasteboard *pboard = [sender draggingPasteboard];
    NSArray *filenames = [pboard propertyListForType:NSFilenamesPboardType];
    NSString *filename = [filenames objectAtIndex:0];
    [self setImagePath:filename];
    [super concludeDragOperation:sender];
}

@end
