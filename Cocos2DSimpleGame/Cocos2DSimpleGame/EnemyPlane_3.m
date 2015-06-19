//
//  EnemyPlane_1.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EnemyPlane_3.h"
#include "EnemyBullet.h"
#include "GameScene.h"
#include "Muzzle.h"
#include "Explosion1.h"
#include "Health.h"
#include "Misile.h"

@implementation EnemyPlane_3 {
    CCPhysicsNode *_physics_world;
}

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world {
    self = [super init];
    if (self) {
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: ENEMY_PLANE_3_IMAGE]];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[ENEMY_COLLISION];
        self.physicsBody.collisionMask = @[PROJECTILE_COLLISION];
        self.physicsBody.collisionType = ENEMY_COLLISION;
        self.physicsBody.velocity = ccp(ENEMY_PLANE_2_SPEED, 0);
        self.scale = PLANE_SCALE_3;
        self.score = ENEMY_PLANE_1_SCORE;
        _physics_world = physics_world;
    }
    return self;
}

- (void) update:(CCTime)delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
    else{
        if (arc4random()%100 > 97) {
            [self shootEnemy:delta];
        }
        if(arc4random()%100 > 98){
            [self shootEnemy2:delta];
        }
    }
    
}

- (void) takeDamage: (int) damage {
    Explosion1* explosion_1 = [[Explosion1 alloc] initWithPosition: self.position withScale: 1.0f withVelocityX:self.physicsBody.velocity.x];
    [explosion_1 schedule:@selector(animate:) interval:	0.05];
    [_physics_world addChild: explosion_1];
    [self healthPowerUp: _physics_world];
    [self removeFromParent];
}

- (void) healthPowerUp: (CCPhysicsNode*) physics_world {
    if (arc4random()%100 > 75) {
        [physics_world addChild: [[Health alloc] initWithPosition:self.position]];
    }
}

- (void)shootEnemy:(CCTime)dt {
    EnemyBullet *bullet = [[EnemyBullet alloc] initWithPosition:ccp(self.position.x - 25, self.position.y)];
    CCPhysicsNode* pw = ((GameScene*)[CCDirector sharedDirector].runningScene).physicsWorld;
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(self.position.x - 25, self.position.y)];
    muzzle.scaleX = -MUZZLE_SCALE;
    muzzle.scaleY = MUZZLE_SCALE;
    [muzzle schedule:@selector(animate:) interval:0.05];
    [pw addChild:muzzle];
    [pw addChild:bullet];
}

- (void)shootEnemy2:(CCTime)dt {
    Misile *missile = [[Misile alloc] initWithPosition:ccp(self.position.x - 25, self.position.y)];
    CCPhysicsNode* pw = ((GameScene*)[CCDirector sharedDirector].runningScene).physicsWorld;
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(self.position.x - 25, self.position.y)];
    muzzle.scaleX = -MUZZLE_SCALE;
    muzzle.scaleY = MUZZLE_SCALE;
    [muzzle schedule:@selector(animate:) interval:0.05];
    [pw addChild:muzzle];
    [pw addChild:missile];
}


@end