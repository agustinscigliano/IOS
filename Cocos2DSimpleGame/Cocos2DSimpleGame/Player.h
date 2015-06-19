//
//  Player.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#include "Constants.h"

@interface Player : CCSprite

@property (nonatomic) int health;
@property (nonatomic) CCTime fire_rate;
@property (nonatomic) int bullet_speed;
@property (nonatomic) CGPoint velocity;
@property (nonatomic) CGPoint final_position;
@property (nonatomic) BOOL isTouched;
@property (nonatomic) int score;
@property (nonatomic) NSString* plane_name;

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world planeName: (NSString*) _plane_name;
- (void) takeDamage:(int) damage;
- (void) recoverHealth: (int) health;

@end
