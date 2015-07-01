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

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world withDifficulty:(int)difficulty {
    self = [super initWithPhysicsWorld:physics_world andSpriteName:ENEMY_PLANE_2_IMAGE andHealth:ENEMY_PLANE_2_HEALTH];
    if (self) {
        self.physicsBody.velocity = ccp(ENEMY_PLANE_2_SPEED, 0);
        self.score = ENEMY_PLANE_2_SCORE;
        self.shooting_probability = ENEMY_PLANE_SHOOTING_PROBABILITY-difficulty;
        self.drop_probability = ENEMY_PLANE_2_DROP_PROBABILITY;
        self.scale=PLANE_SCALE_2;
    }
    return self;
}

@end