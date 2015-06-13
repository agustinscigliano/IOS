//
//  Muzzle.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Muzzle.h"
#import "Constants.h"

@implementation Muzzle {
    int frame_number;
}

- (id) initWithPosition:(CGPoint)position {
    self = [self initWithImageNamed: MUZZLE_IMAGE];
    frame_number = 1;
    self.position = position;
    self.scale = MUZZLE_SCALE;
    return self;
}

- (void) animate:(CCTime)dt {
    frame_number++;
    if (frame_number == MAX_FRAMES_FOR_MUZZLE)
        [self removeFromParent];
}

@end