//
//  Projectile.m
//  Cocos2DSimpleGame
//
//  Created by Agustin Scigliano on 5/29/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import "cocos2d.h"
#import "Projectile.h"
#import "Constants.h"

#define DAMAGE ((int) 5)

@implementation Projectile {
    int _screen_size;
}

- (id) initWithPosition:(CGPoint)position withSpeed: (int) speed screenSize: (int) screen_size {
    self = [super initWithImageNamed: BULLET_IMAGE];
    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
    self.physicsBody.collisionMask = @[ENEMY_COLLISION, PROJECTILE_COLLISION];
    self.physicsBody.collisionCategories = @[PROJECTILE_COLLISION];
    self.physicsBody.collisionType  = PROJECTILE_COLLISION;
    self.physicsBody.velocity = ccp(speed, 0);
    self.position = position;
    self.damage = DAMAGE;
    self.scaleX = BULLET_SCALE_X;
    self.scaleY = BULLET_SCALE_Y;
    _screen_size = screen_size;
    return self;
}

- (void) update:(CCTime)delta {
    if (self.position.x > _screen_size + self.contentSize.width || self.position.x < -self.contentSize.width) {
        [self removeFromParent ];
    }
}

@end

