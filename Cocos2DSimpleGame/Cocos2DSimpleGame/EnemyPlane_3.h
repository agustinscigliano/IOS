//
//  EnemyPlane_2.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#include "Constants.h"

@interface EnemyPlane_3 : CCSprite

@property (nonatomic) int score;

- (void) takeDamage: (int) damage;
- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world;
@end
