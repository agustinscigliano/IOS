//
//  Player.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#include "Constants.h"
#import "GameScene.h"

@interface Player : CCSprite

@property (nonatomic) int health;
@property (nonatomic) CCTime fire_rate;
@property (nonatomic) int bullet_speed;
@property (nonatomic) CGPoint velocity;
@property (nonatomic) CGPoint final_position;
@property (nonatomic) BOOL isTouched;
@property (nonatomic) NSString* plane_name;
@property (nonatomic) int credits;
@property (nonatomic) BOOL player_dead;

- (id) initWithPlaneName: (NSString*) plane_name withGameScene: (GameScene*) gs;
- (void) takeDamage:(int) damage;
- (void) recoverHealth: (int) health;
- (void) updateFireRate: (CCTime) fire_rate;
- (void) trippleShot;
- (void) rapidFire;
- (void) rocketPowerup;

@end
