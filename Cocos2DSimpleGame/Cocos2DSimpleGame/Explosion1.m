//
//  Explosion1.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Explosion1.h"
#import "Constants.h"

@implementation Explosion1 {
    int frame_number;
}

- (id) initWithPosition:(CGPoint)position withScale: (float) scale {
    frame_number = 1;
    NSString* image_path = [NSString stringWithFormat: @"%@%d.png", EXPLOSION_1_IMAGE, frame_number];
    self = [super initWithImageNamed: image_path];
    self.position = position;
    self.scale = scale;
    return self;
}

- (void) animate: (CCTime) dt {
    NSString *frame_path = [NSString stringWithFormat:@"%@%d.png", EXPLOSION_1_IMAGE, frame_number];
    [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: frame_path]];
    frame_number++;
    if (frame_number == MAX_FRAMES_FOR_EXPLOSION_1)
        [self removeFromParent];
}

@end