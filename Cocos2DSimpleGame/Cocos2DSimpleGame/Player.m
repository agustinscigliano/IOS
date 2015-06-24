//
//  Player.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Projectile.h"
#import "Muzzle.h"
#import "Constants.h"
#define SPEED 200
#define POSITION_DELTA 5.0f

@implementation Player {
    CCPhysicsNode* physics_world;
    NSTimeInterval tripple_shot_timeout;
    NSTimeInterval rapid_fire_timeout;
    BOOL triple_shoot_power_up;
    BOOL rapid_fire_power_up;
    int _screen_size;
}

- (id) initWithPlaneName: (NSString*) plane_name {
    self = [super init];
    if (self) {
        self.plane_name = plane_name;
        self = [super initWithImageNamed: self.plane_name];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionType = PLAYER_COLLISION;
        self.physicsBody.type = CCPhysicsBodyTypeStatic;
        self.fire_rate = DEFAULT_SHOOTING_RATE;
        self.bullet_speed = DEFAULT_BULLET_SPEED;
        self.scale = PLANE_SCALE;
        self.health = 100;
        triple_shoot_power_up = NO;
        rapid_fire_power_up = NO;
    }
    return self;
}

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physicsWorld planeName:(NSString *)plane_name withScreenSize: (int) screen_size {
    self = [self initWithPlaneName: plane_name];
    physics_world = physicsWorld;
    _screen_size = screen_size;
    return self;
}

- (void) trippleShot {
    triple_shoot_power_up = YES;
    [self schedule:@selector(stopTrippleShot:) interval:10 repeat:0 delay:10];
}

- (void) stopTrippleShot:(CCTime)dt {
    triple_shoot_power_up = NO;
    [self unschedule:@selector(stopTrippleShot:)];
}

- (void) stopRapidFire:(CCTime)dt {
    rapid_fire_power_up = NO;
    [self updateFireRate:DEFAULT_SHOOTING_RATE];
    [self unschedule:@selector(stopRapidFire:)];
}

- (void) rapidFire {
    rapid_fire_power_up = YES;
    [self updateFireRate:0.15];
    [self schedule:@selector(stopRapidFire:) interval:100 repeat:0 delay:10];
}

- (void) update:(CCTime)delta {
    CGPoint position_difference = ccpSub(_final_position, self.position);
    if(_isTouched && sqrt(pow(position_difference.x, 2) + pow(position_difference.y, 2)) > POSITION_DELTA) {
        [self setPosition:ccp(self.position.x + _velocity.x * SPEED * delta, self.position.y + _velocity.y * SPEED * delta)];
    }
}

- (void) takeDamage:(int)damage {
    _health -= damage;
}

- (void) recoverHealth:(int)health {
    if (_health + health > 100) {
        _health = 100;
    } else {
        _health += health;
    }
}

- (void) addScore: (int) score {
    _score += score;
}

- (void) updateFireRate: (CCTime) fire_rate {
    [self unschedule: @selector(shoot:)];
    [self schedule:@selector(shoot:) interval:fire_rate];
}

- (void)shoot:(CCTime)dt {
    CGPoint shoot_position = ccp(self.position.x + 50, self.position.y);
    if (triple_shoot_power_up) {
        [self trippleShot:dt from: shoot_position];
    } else {
        [self shootNormalBullet:dt from: shoot_position];
    }
}

- (void)trippleShot: (CCTime)dt from: (CGPoint)position {
    [self shootNormalBullet:dt from:position];
    [self shootDiagonal:dt from:position direction: -1];
    [self shootDiagonal:dt from:position direction: 1];
}

- (void)shootDiagonal:(CCTime)dt from:(CGPoint)position direction:(int)direction {
    Projectile *projectile = [[Projectile alloc] initWithPosition:position withSpeed: (self.bullet_speed + self.physicsBody.velocity.x) screenSize:_screen_size];
    projectile.rotation = -direction*5;
    projectile.physicsBody.velocity = ccp(500, direction*100);
    [physics_world addChild:projectile];
}

- (void)shootNormalBullet:(CCTime)dt from:(CGPoint)position {
    Projectile *projectile = [[Projectile alloc] initWithPosition:position withSpeed: (self.bullet_speed + self.physicsBody.velocity.x) screenSize:_screen_size];
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(0.9, 0.5)];
    muzzle.positionType = CCPositionTypeNormalized;
    [muzzle schedule:@selector(animate:) interval:0.05];
    [physics_world addChild:projectile];
    [self addChild:muzzle];
}

@end