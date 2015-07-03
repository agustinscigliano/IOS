//
//  Boss.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 2/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Boss.h"
#include "EnemyBullet.h"
#include "GameScene.h"
#include "Muzzle.h"
#include "Explosion1.h"
#include "Health.h"
#include "Misile.h"

@implementation Boss {
    CCScene *game_scene;
    int health;
    int shooting_probability;
    int y_value;
}

- (id) initWithGameScene: (CCScene*) gs withDifficulty:(int)difficulty {
    self = [super init];
    if (self) {
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: BOSS_SPRITE]];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[BOSS_COLLISION];
        self.physicsBody.collisionType = BOSS_COLLISION;
        self.physicsBody.sensor = YES;
        self.scale = PLANE_SCALE;
        health = BOSS_HEALTH;
        game_scene = gs;
        self.physicsBody.velocity = ccp(ENEMY_PLANE_3_SPEED, 0);
        self.score = ENEMY_PLANE_3_SCORE;
        shooting_probability = ENEMY_PLANE_SHOOTING_PROBABILITY - difficulty;
        self.scale=PLANE_SCALE_3;
    }
    return self;
}

- (void) update:(CCTime)delta
{
    int step = 100;
    [self setPosition: ccp(self.position.x - step*delta, self.position.y - y_value*delta)];
    if (self.position.x < game_scene.contentSize.width*0.8) {
        self.physicsBody.velocity = ccp(0,0);
        if (arc4random() % 10 == 0) {
            int lowerBound = -step;
            int upperBound = step;
            y_value = lowerBound + arc4random() % (upperBound - lowerBound);
        }
    } else {
        self.physicsBody.velocity = ccp(ENEMY_PLANE_1_SPEED, 0);
    }
}

//- (void) update:(CCTime)delta {
//    if (self.position.x < -self.contentSize.width) {
//        [self removeFromParent];
//    }
//    else{
//        if (arc4random()%100 > shooting_probability) {
//            [self shootEnemy];
//        }
//        if(arc4random()%100 > ENEMY_PLANE_MISSILE_PROBABILITY){
//            [self shootEnemy2];
//        }
//    }
//    
//}

@end