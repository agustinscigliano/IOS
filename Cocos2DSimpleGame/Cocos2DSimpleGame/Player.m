//
//  Player.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#define SPEED ((int) 200)
#define POSITION_DELTA ((float) 5.0)
#define DEFAULT_SHOOTING_TIME ((float) 0.5)
#define DEFAULT_BULLET_SPEED ((int) 750)

@implementation Player

+ (Player*) spriteWithImageNamed:(NSString *)name
{
    Player *player = [super spriteWithImageNamed:name];
    player.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, player.contentSize} cornerRadius:0]; // 1
    player.physicsBody.collisionGroup = @"playerGroup"; // 2
    player.physicsBody.collisionType = @"playerCollision";
    player.fire_rate = DEFAULT_SHOOTING_TIME;
    player.bullet_speed = DEFAULT_BULLET_SPEED;
    return player;
}

- (void) update:(CCTime)delta
{
    CGPoint position_difference = ccpSub(_final_position, self.position);
    if(_isTouched && sqrt(pow(position_difference.x, 2) + pow(position_difference.y, 2)) > POSITION_DELTA)
    {
        [self setPosition:ccp(self.position.x + _velocity.x * SPEED * delta, self.position.y + _velocity.y * SPEED * delta)];
    }
}

@end