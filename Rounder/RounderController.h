//
//  RounderController.h
//  Rounder
//
//  Created by Mikhail B. Petrov on 09.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RounderController : NSObjectController {
    IBOutlet NSImageView *sourceImage;
    
}
- (IBAction)processImage:(id)sender;
- (IBAction)loadSourceImage:(id)sender;

@end
