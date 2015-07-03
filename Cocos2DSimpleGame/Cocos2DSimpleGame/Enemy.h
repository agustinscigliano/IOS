//
//  Enemy.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 24/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#import "Explosion1.h"
#import "Constants.h"
#import "EnemyBullet.h"
#import "Muzzle.h"
#import "Sparkle.h"
#import "PowerUpFactory.h"

@interface Enemy : CCSprite

@property (nonatomic) int health;
@property (nonatomic) int score;
@property (nonatomic) int shooting_probability;
@property (nonatomic) int drop_probability;

- (BOOL) takeDamage:(int) damage;
- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world andSpriteName: (NSString*) sprite_name andHealth: (int) heath;
- (void) shootEnemy;

@end
