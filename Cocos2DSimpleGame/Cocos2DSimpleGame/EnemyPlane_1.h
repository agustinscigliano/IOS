//
//  EnemyPlane_1.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#include "Constants.h"

@interface EnemyPlane_1 : CCSprite

@property (nonatomic) int score;

- (void) takeDamage: (int) damage;
- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world;

@end