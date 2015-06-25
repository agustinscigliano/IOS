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

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world withDifficulty: (int) difficulty {
    self = [super initWithPhysicsWorld:physics_world andSpriteName:ENEMY_PLANE_3_IMAGE andHealth:ENEMY_PLANE_3_HEALTH];
    if (self) {
        self.physicsBody.velocity = ccp(ENEMY_PLANE_3_SPEED, 0);
        self.score = ENEMY_PLANE_3_SCORE;
        self.drop_probability = ENEMY_PLANE_3_DROP_PROBABILITY;
        self.shooting_probability = ENEMY_PLANE_SHOOTING_PROBABILITY - difficulty;
        self.scale=PLANE_SCALE_3;
    }
    return self;
}

- (void) update:(CCTime)delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
    else{
        if (arc4random()%100 > self.shooting_probability) {
            [self shootEnemy];
        }
        if(arc4random()%100 > ENEMY_PLANE_MISSILE_PROBABILITY){
            [self shootEnemy2];
        }
    }
    
}

- (void)shootEnemy2 {
    Misile *missile = [[Misile alloc] initWithPosition:ccp(self.position.x - 25, self.position.y)];
    CCPhysicsNode* pw = ((GameScene*)[CCDirector sharedDirector].runningScene).physicsWorld;
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(0.1, 0.5)];
    muzzle.positionType = CCPositionTypeNormalized;
    muzzle.scaleX = -MUZZLE_SCALE;
    muzzle.scaleY = MUZZLE_SCALE;
    [muzzle schedule:@selector(animate:) interval:0.05];
    [self addChild:muzzle];
    [pw addChild:missile];
}

@end