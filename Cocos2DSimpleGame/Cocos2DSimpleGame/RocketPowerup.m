//
//  RocketPowerup.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 1/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RocketPowerup.h"
#import "Constants.h"

@implementation RocketPowerup

- (id) initWithPosition: (CGPoint) position {
    self = [super initWithImageNamed:@"rocket-powerup.png"];
    [super initializeWithPosition: position];
    self.physicsBody.collisionCategories = @[ROCKET_POWERUP_COLLISION];
    self.physicsBody.collisionType  = ROCKET_POWERUP_COLLISION;
    self.scale = ROCKET_POWERUP_SCALE;
    return self;
}

@end
