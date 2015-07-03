//
//  Boss.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 2/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//


#import "cocos2d.h"
#import "Constants.h"
#import "Player.h"
#import "EnemyBullet.h"
#import "GameScene.h"
#import "Muzzle.h"
#import "Explosion1.h"
#import "Health.h"
#import "Misile.h"
#import "Sparkle.h"
#import "Player.h"
#import "GameOver.h"
#import "PowerUpFactory.h"

@interface Boss : CCSprite

@property (nonatomic) int score;
@property (nonatomic) BOOL is_alive;

- (id) initWithGameScene: (GameScene*) gs withDifficulty:(int)difficulty withPlayer: (Player*) p;
- (BOOL) takeDamage:(int) damage;
@end