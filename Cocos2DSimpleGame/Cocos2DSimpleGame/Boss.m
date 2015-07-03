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
    int direction;
}

- (id) initWithGameScene: (CCScene*) gs withDifficulty:(int)difficulty {
    self = [super init];
    if (self) {
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: BOSS_SPRITE]];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[BOSS_COLLISION];
        self.physicsBody.collisionType = BOSS_COLLISION;
        self.physicsBody.sensor = YES;
        health = BOSS_HEALTH;
        game_scene = gs;
        self.score = ENEMY_PLANE_3_SCORE;
        self.scale = BOSS_SCALE;
        shooting_probability = ENEMY_PLANE_SHOOTING_PROBABILITY - difficulty;
        self.position = ccp(game_scene.contentSize.width, game_scene.contentSize.height/2);
        direction = GOING_UP;
    }
    return self;
}

- (void) update:(CCTime)delta
{
    if (self.position.x < game_scene.contentSize.width*0.8) {
        if (direction == GOING_UP) {
            if (self.position.y > game_scene.contentSize.height * 0.9) {
                direction = GOING_DOWN;
            } else {
                self.physicsBody.velocity = ccp(0, 50);
            }
        } else {
            if (self.position.y < game_scene.contentSize.height *0.1) {
                direction = GOING_UP;
            } else {
                self.physicsBody.velocity = ccp(0, -50);
            }
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