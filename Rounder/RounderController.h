//
//  RounderController.h
//  Rounder
//
//  Created by Mikhail B. Petrov on 09.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageView.h"

@interface RounderController : NSObjectController {
    IBOutlet ImageView *sourceImage;
    IBOutlet NSTextField *widthField;
    IBOutlet NSTextField *radiusField;
    IBOutlet NSColorWell *colorField;
    
}
- (IBAction)loadSourceImage:(id)sender;

@end
