//
//  EnemyPlane_2.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "EnemyPlane_2.h"
#include "Misile.h"
#include "GameScene.h"

@implementation EnemyPlane_2

- (id) init {
    self = [super init];
    if (self) {
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: ENEMY_PLANE_2_IMAGE]];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[ENEMY_COLLISION];
        self.physicsBody.collisionMask = @[PROJECTILE_COLLISION];
        self.physicsBody.collisionType = ENEMY_COLLISION;
        self.physicsBody.velocity = ccp(ENEMY_PLANE_1_SPEED, 0);
        self.scale = PLANE_SCALE;
        self.score = ENEMY_PLANE_1_SCORE;
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

- (void)shootEnemy:(CCTime)dt{
    Misile *misile = [Misile spriteWithImageNamed:@"misile.png" position:self.position];
    misile.physicsBody.velocity = ccp(-DEFAULT_BULLET_SPEED + self.physicsBody.velocity.x, 0);
    CCPhysicsNode* pw = ((GameScene*)[CCDirector sharedDirector].runningScene).physicsWorld;
    [pw addChild:misile];
}

@end