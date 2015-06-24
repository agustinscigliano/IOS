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

@implementation Enemy {
    CCPhysicsNode *_physics_world;
}

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physics_world andSpriteName: (NSString*) sprite_name andHealth: (int) heath {
    self = [super init];
    if (self) {
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: sprite_name]];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[ENEMY_COLLISION];
        self.physicsBody.collisionMask = @[PROJECTILE_COLLISION];
        self.physicsBody.collisionType = ENEMY_COLLISION;
        self.scale = PLANE_SCALE;
        _health = heath;
        _physics_world = physics_world;
    }
    return self;
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
    return NO;
}

- (void) dropPowerUp {
    int powerup_selector = arc4random() % 4;
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
        default:
            break;
    }
}

- (void) healthPowerUp {
    if (arc4random()%100 > 75) {
        [_physics_world addChild: [[Health alloc] initWithPosition:self.position]];
    }
}

- (void) trippleShootPowerUp {
    if (arc4random()%100 > 75) {
        [_physics_world addChild: [[TrippleShot alloc] initWithPosition:self.position]];
    }
}

- (void)rapidFirePowerUp {
    if (arc4random()%100 > 75) {
        [_physics_world addChild: [[RapidFire alloc] initWithPosition:self.position]];
    }
}

@end