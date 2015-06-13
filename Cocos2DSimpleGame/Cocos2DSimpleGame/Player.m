//
//  Player.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#define SPEED 200
#define POSITION_DELTA 5.0f

@implementation Player {
    int frame_number;
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

- (void) animate:(CCTime)dt {
    NSString *path = [NSString stringWithFormat:@"%@%d.png", _plane_name, frame_number];
    [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed:path]];
    frame_number++;
    if (frame_number == MAX_FRAMES_FOR_PLANES)
        frame_number = 1;
}

@end