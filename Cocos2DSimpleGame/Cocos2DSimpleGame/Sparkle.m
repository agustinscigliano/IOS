//
//  Sparkle.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparkle.h"
#import "Constants.h"

@implementation Sparkle {
    int frame_number;
}

- (id) initWithPosition:(CGPoint)position {
    self = [self initWithImageNamed: SPARKLE_IMAGE];
    frame_number = 1;
    self.position = position;
    self.scale = SPARKLE_SCALE;
    [self schedule:@selector(animate:) interval:0.05];
    return self;
}

- (void) animate:(CCTime)dt {
    frame_number++;
    if (frame_number == MAX_FRAMES_FOR_MUZZLE)
        [self removeFromParent];
}

@end
