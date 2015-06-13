//
//  EnemyPlane_1.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EnemyPlane_1.h"
#include "Misile.h"
#include "GameScene.h"

@implementation EnemyPlane_1

- (id) init {
    self = [super init];
    if (self) {
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: ENEMY_PLANE_1_IMAGE]];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[ENEMY_COLLISION];
        self.physicsBody.collisionMask = @[PROJECTILE_COLLISION];
        self.physicsBody.collisionType = ENEMY_COLLISION;
        self.physicsBody.velocity = ccp(ENEMY_PLANE_1_SPEED, 0);
        self.scaleX = ENEMY_PLANE_1_SCALE;
        self.scaleY = ENEMY_PLANE_1_SCALE;
    }
    return self;
}

- (void) update:(CCTime)delta {
    if (arc4random()%100 > 98) {
        [self shootEnemy:delta];
    }
}

- (void)shootEnemy:(CCTime)dt{
    Misile *misile = [Misile spriteWithImageNamed:@"misile.png" position:self.position];
    misile.physicsBody.velocity = ccp(ENEMY_PLANE_1_BULLET_SPEED + self.physicsBody.velocity.x, 0);
    CCPhysicsNode* pw = ((GameScene*)[CCDirector sharedDirector].runningScene).physicsWorld;
    [pw addChild:misile];
}

@end