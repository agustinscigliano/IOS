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
    self = [super initWithPhysicsWorld:physics_world andSpriteName:ENEMY_PLANE_3_IMAGE andHealth:ENEMY_PLANE_3_HEALTH];
    if (self) {
        self.physicsBody.velocity = ccp(ENEMY_PLANE_3_SPEED, 0);
        self.score = ENEMY_PLANE_3_SCORE;
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

- (void)shootEnemy2:(CCTime)dt {
    Misile *missile = [[Misile alloc] initWithPosition:ccp(self.position.x - 25, self.position.y)];
    CCPhysicsNode* pw = ((GameScene*)[CCDirector sharedDirector].runningScene).physicsWorld;
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(0.1, 0.5)];
    muzzle.positionType = CCPositionTypeNormalized;
    muzzle.scaleX = -MUZZLE_SCALE;
    muzzle.scaleY = MUZZLE_SCALE;
    [muzzle schedule:@selector(animate:) interval:0.05];
    [pw addChild:muzzle];
    [pw addChild:missile];
}


@end