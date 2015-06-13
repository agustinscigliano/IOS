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
#define SPEED 200
#define POSITION_DELTA 5.0f

@implementation Player {
    
    int frame_number;
    CCPhysicsNode* physics_world;
}

- (id) init {
    self = [super init];
    if (self) {
        self.plane_name = @"p51-";
        frame_number = 1;
        NSString *plane_image_path = [NSString stringWithFormat:@"%@%d.png", _plane_name, frame_number];
        self = [super initWithImageNamed: plane_image_path];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionType = PLAYER_COLLISION;
        self.physicsBody.type = CCPhysicsBodyTypeStatic;
        self.fire_rate = DEFAULT_SHOOTING_RATE;
        self.bullet_speed = DEFAULT_BULLET_SPEED;
        self.scaleX = PLAYER_SCALE;
        self.scaleY = PLAYER_SCALE;
    }
    return self;
}

- (id) initWithPhysicsWorld: (CCPhysicsNode*) physicsWorld {
    self = [self init];
    physics_world = physicsWorld;
    return self;
}

- (void) update:(CCTime)delta {
    CGPoint position_difference = ccpSub(_final_position, self.position);
    if(_isTouched && sqrt(pow(position_difference.x, 2) + pow(position_difference.y, 2)) > POSITION_DELTA)
    {
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

- (void)shoot:(CCTime)dt {
    //ACA HABRIA QUE AGREGAR "IF TAL POWER UP THEN DISPARO_ZARPADO... ELSE SHOOT_NORMAL_BULLET"
    [self shootNormalBullet:dt from:ccp(self.position.x + 50, self.position.y) withSpeed: self.bullet_speed + self.physicsBody.velocity.x];
}

- (void)shootNormalBullet:(CCTime)dt from:(CGPoint)position withSpeed: (int) speed {
    Projectile *projectile = [[Projectile alloc] initWithPosition: position withSpeed: speed];
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(position.x - 25, position.y)];
    [muzzle schedule:@selector(animate:) interval:0.05];
    [physics_world addChild:projectile];
    [physics_world addChild:muzzle];
}

@end