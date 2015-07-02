//
//  ShieldPowerUp.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 1/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShieldPowerUp.h"
#import "Constants.h"

@implementation ShieldPowerUp

- (id) initWithPosition: (CGPoint) position {
    self = [super initWithImageNamed:@"shield-powerup.png"];
    [super initializeWithPosition:position];
    self.physicsBody.collisionCategories = @[SHIELD_POWERUP_COLLISION];
    self.physicsBody.collisionType  = SHIELD_POWERUP_COLLISION;
    self.scale = SHIELD_POWERUP_SCALE;
    return self;
}

@end