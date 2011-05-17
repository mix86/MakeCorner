//
//  ImageView.h
//  Rounder
//
//  Created by Mikhail B. Petrov on 11.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageView : NSImageView {
    NSString *imagePath;
}
@property(readwrite, assign)
    NSString *imagePath;

-(void)concludeDragOperation:(id <NSDraggingInfo>)sender;

@end
