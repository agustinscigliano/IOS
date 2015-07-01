//
//  PlayerRocket.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 1/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import "cocos2d.h"
#import "PlayerRocket.h"
#import "Constants.h"

#define DAMAGE ((int) 15)

@implementation PlayerRocket

-(id)initWithPosition: (CGPoint)position {
    self = [super initWithImageNamed:MISSILE_IMAGE];
    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
    self.physicsBody.collisionCategories = @[PLAYER_ROCKET_COLLISION];
    self.physicsBody.collisionType  = PLAYER_ROCKET_COLLISION;
    self.physicsBody.velocity = ccp(PLAYER_ROCKET_SPEED, 0);
    self.scaleX = -MISILE_SCALE_X;
    self.scaleY = MISILE_SCALE_Y;
    self.position = position;
    _damage = DAMAGE;
    return self;
}

- (void) update:(CCTime) delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
}

@end

