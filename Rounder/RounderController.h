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
    IBOutlet NSTextField *widthField;
    IBOutlet NSTextField *radiusField;
    IBOutlet NSColorWell *colorField;
    
}
- (IBAction)loadSourceImage:(id)sender;

@end
