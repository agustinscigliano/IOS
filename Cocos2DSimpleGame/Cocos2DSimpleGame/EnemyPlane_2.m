//
//  EnemyPlane_1.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EnemyPlane_2.h"
#include "EnemyBullet.h"
#include "GameScene.h"
#include "Muzzle.h"
#include "Explosion1.h"
#include "Health.h"

@implementation EnemyPlane_2 {
    CCPhysicsNode *_physics_world;
}

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world {
    self = [super initWithPhysicsWorld:physics_world andSpriteName:ENEMY_PLANE_2_IMAGE andHealth:ENEMY_PLANE_2_HEALTH];
    if (self) {
        self.physicsBody.velocity = ccp(ENEMY_PLANE_2_SPEED, 0);
        self.score = ENEMY_PLANE_2_SCORE;
        self.shooting_probability = ENEMY_PLANE_SHOOTING_PROBABILITY;
    }
    return self;
}

- (void)shootEnemy:(CCTime)dt {
    EnemyBullet *bullet = [[EnemyBullet alloc] initWithPosition:ccp(self.position.x - 25, self.position.y)];
    CCPhysicsNode* pw = ((GameScene*)[CCDirector sharedDirector].runningScene).physicsWorld;
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(0.1, 0.5)];
    muzzle.positionType = CCPositionTypeNormalized;
    muzzle.scaleX = -MUZZLE_SCALE;
    muzzle.scaleY = MUZZLE_SCALE;
    [muzzle schedule:@selector(animate:) interval:0.05];
    [pw addChild:muzzle];
    [pw addChild:bullet];
}

@end