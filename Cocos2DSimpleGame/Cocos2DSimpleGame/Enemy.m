//
//  Enemy.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 24/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy.h"
#import "Explosion1.h"
#import "Constants.h"
#import "Health.h"
#import "TrippleShot.h"
#import "RapidFire.h"
#import "EnemyBullet.h"
#import "Muzzle.h"
#import "Sparkle.h"
#import "RocketPowerup.h"
#import "ShieldPowerUp.h"

@implementation Enemy {
    CCPhysicsNode *_physics_world;
}

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world andSpriteName: (NSString*) sprite_name andHealth: (int) heath {
    self = [super init];
    if (self) {
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: sprite_name]];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[ENEMY_COLLISION];
        self.physicsBody.collisionType = ENEMY_COLLISION;
        self.physicsBody.sensor = YES;
        self.scale = PLANE_SCALE;
        _health = heath;
        _physics_world = physics_world;
    }
    return self;
}

- (void) update:(CCTime)delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
    else if (arc4random()%100 > self.shooting_probability) {
        [self shootEnemy];
    }
}

- (void) shootEnemy {
    EnemyBullet *bullet = [[EnemyBullet alloc] initWithPosition:ccp(self.position.x - 25, self.position.y)];
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(0.1, 0.5)];
    muzzle.positionType = CCPositionTypeNormalized;
    muzzle.scaleX = -MUZZLE_SCALE;
    muzzle.scaleY = MUZZLE_SCALE;
    [muzzle schedule:@selector(animate:) interval:0.05];
    [self addChild:muzzle];
    [_physics_world addChild:bullet];
}

- (BOOL) takeDamage: (int) damage {
    _health -= damage;
    if (_health <= 0) {
        Explosion1* explosion_1 = [[Explosion1 alloc] initWithPosition: self.position withScale: 1.0f withVelocityX:self.physicsBody.velocity.x];
        [explosion_1 schedule:@selector(animate:) interval:	0.05];
        [_physics_world addChild: explosion_1];
        [self dropPowerUp];
        [self removeFromParent];
        return YES;
    }
    int random_sound_index = (arc4random() % 2) + 1;
    NSString* random_sound_name = [NSString stringWithFormat:@"hit_%d.mp3", random_sound_index];
    [[OALSimpleAudio sharedInstance] playEffect:random_sound_name];
    [self addChild: [[Sparkle alloc] init]];
    return NO;
}

- (void) dropPowerUp {
    int powerup_selector = arc4random() % POWERUPS_AMMOUNT;
    switch (powerup_selector) {
        case 0:
            [self healthPowerUp];
            break;
        case 1:
            [self trippleShootPowerUp];
            break;
        case 2:
            [self rapidFirePowerUp];
            break;
        case 3:
            [self rocketPowerup];
            break;
        case 4:
            [self shieldPowerup];
            break;
        default:
            break;
    }
}

- (void) healthPowerUp {
    if (arc4random()%100 > _drop_probability) {
        [_physics_world addChild: [[Health alloc] initWithPosition:self.position]];
    }
}

- (void) trippleShootPowerUp {
    if (arc4random()%100 > _drop_probability) {
        [_physics_world addChild: [[TrippleShot alloc] initWithPosition:self.position]];
    }
}

- (void)rapidFirePowerUp {
    if (arc4random()%100 > _drop_probability) {
        [_physics_world addChild: [[RapidFire alloc] initWithPosition:self.position]];
    }
}

- (void)rocketPowerup {
    if (arc4random()%100 > _drop_probability) {
        [_physics_world addChild: [[RocketPowerup alloc] initWithPosition:self.position]];
    }
}

- (void) shieldPowerup {
    if (arc4random()%100 > _drop_probability) {
        [_physics_world addChild: [[ShieldPowerUp alloc] initWithPosition:self.position]];
    }
}

@end