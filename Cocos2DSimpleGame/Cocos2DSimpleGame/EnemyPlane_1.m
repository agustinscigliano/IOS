//
//  EnemyPlane_1.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EnemyPlane_1.h"
#include "EnemyBullet.h"
#include "GameScene.h"
#include "Muzzle.h"
#include "Explosion1.h"
#include "Health.h"
#include "TrippleShot.h"
#include "RapidFire.h"

@implementation EnemyPlane_1 {
    CCPhysicsNode *_physics_world;
}

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world {
    self = [super init];
    if (self) {
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: ENEMY_PLANE_1_IMAGE]];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[ENEMY_COLLISION];
        self.physicsBody.collisionMask = @[PROJECTILE_COLLISION];
        self.physicsBody.collisionType = ENEMY_COLLISION;
        self.physicsBody.velocity = ccp(ENEMY_PLANE_1_SPEED, 0);
        self.scale = PLANE_SCALE;
        self.score = ENEMY_PLANE_1_SCORE;
        _physics_world = physics_world;
    }
    return self;
}

- (void) update:(CCTime)delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
    else if (arc4random()%100 > 98) {
        [self shootEnemy:delta];
    }
}

- (void) takeDamage: (int) damage {
    Explosion1* explosion_1 = [[Explosion1 alloc] initWithPosition: self.position withScale: 1.0f withVelocityX:self.physicsBody.velocity.x];
    [explosion_1 schedule:@selector(animate:) interval:	0.05];
    [_physics_world addChild: explosion_1];
    [self healthPowerUp: _physics_world];
    [self trippleShootPowerUp: _physics_world];
    [self rapidFirePowerUp: _physics_world];
    [self removeFromParent];
}

- (void) healthPowerUp: (CCPhysicsNode*) physics_world {
    if (arc4random()%100 > 75) {
        [physics_world addChild: [[Health alloc] initWithPosition:self.position]];
    }
}

- (void) trippleShootPowerUp: (CCPhysicsNode*) physics_world {
    if (arc4random()%100 > 75) {
        [physics_world addChild: [[TrippleShot alloc] initWithPosition:self.position]];
    }
}

- (void)rapidFirePowerUp: (CCPhysicsNode*) physics_world {
    if (arc4random()%100 > 75) {
        [physics_world addChild: [[RapidFire alloc] initWithPosition:self.position]];
    }
}

- (void)shootEnemy:(CCTime)dt {
    EnemyBullet *bullet = [[EnemyBullet alloc] initWithPosition:ccp(self.position.x - 25, self.position.y)];
    CCPhysicsNode* pw = ((GameScene*)[CCDirector sharedDirector].runningScene).physicsWorld;
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(0.1, 0.5)];
    muzzle.positionType = CCPositionTypeNormalized;
    muzzle.scaleX = -MUZZLE_SCALE;
    muzzle.scaleY = MUZZLE_SCALE;
    [muzzle schedule:@selector(animate:) interval:0.05];
    [self addChild:muzzle];
    [pw addChild:bullet];
}

@end