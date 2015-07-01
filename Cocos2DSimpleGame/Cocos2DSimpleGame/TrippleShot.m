//
//  TrippleShot.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrippleShot.h"
#import "Constants.h"

@implementation TrippleShot

- (id) initWithPosition: (CGPoint) position {
    self = [super initWithImageNamed:@"triple-shot.png"];
    [super initializeWithPosition:position];
    self.physicsBody.collisionCategories = @[TRIPPLE_SHOT_COLLISION];
    self.physicsBody.collisionType  = TRIPPLE_SHOT_COLLISION;
    self.scale = HEALTH_SCALE;
    return self;
}

@end