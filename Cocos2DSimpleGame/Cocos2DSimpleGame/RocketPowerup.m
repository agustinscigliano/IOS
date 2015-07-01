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
    self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:self.contentSize.width/2.0f andCenter:self.anchorPointInPoints];
    self.physicsBody.collisionCategories = @[ROCKET_POWERUP_COLLISION];
    self.physicsBody.collisionMask = @[ENEMY_COLLISION, MISSILE_COLLISION, BULLET_COLLISION, ENEMY_BULLET_COLLISION];
    self.physicsBody.collisionType  = ROCKET_POWERUP_COLLISION;
    self.physicsBody.velocity = ccp(-100, 0);
    self.position = position;
    self.scale = ROCKET_POWERUP_SCALE;
    return self;
}

-(void) update:(CCTime)delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
}

@end
