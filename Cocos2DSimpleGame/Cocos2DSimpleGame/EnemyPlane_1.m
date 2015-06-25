//
//  EnemyPlane_1.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EnemyPlane_1.h"
#include "GameScene.h"
#include "Explosion1.h"
#include "Health.h"
#include "TrippleShot.h"
#include "RapidFire.h"

@implementation EnemyPlane_1 {
    CCPhysicsNode *_physics_world;
}

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world {
    self = [super initWithPhysicsWorld:physics_world andSpriteName:ENEMY_PLANE_1_IMAGE andHealth:ENEMY_PLANE_1_HEALTH];
    if (self) {
        self.physicsBody.velocity = ccp(ENEMY_PLANE_1_SPEED, 0);
        self.score = ENEMY_PLANE_1_SCORE;
        self.shooting_probability = ENEMY_PLANE_SHOOTING_PROBABILITY;
        self.drop_probability = ENEMY_PLANE_1_DROP_PROBABILITY;
    }
    return self;
}

@end