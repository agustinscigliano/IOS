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
#define DEFAULT_SHOOTING_TIME ((float) 3)
#define DEFAULT_BULLET_SPEED ((int) 750)
#define FRAMES ((int) 5)

@implementation Player {
    int frame_number;
    NSString* plane_name;
}

+ (Player*) spriteWithImageNamed:(NSString *)name
{
    Player *player = [super spriteWithImageNamed:name];
    player.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, player.contentSize} cornerRadius:0];
    player.physicsBody.collisionGroup = @"playerGroup";
    player.physicsBody.collisionType = @"playerCollision";
    player.physicsBody.type = CCPhysicsBodyTypeStatic;
    player.fire_rate = DEFAULT_SHOOTING_TIME;
    player.bullet_speed = DEFAULT_BULLET_SPEED;
    player.plane_name = @"p51";
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

- (void) takeDamage:(int)damage
{
    _health -= damage;
}

- (void) recoverHealth:(int)health
{
    if (_health + health > 100) {
        _health = 100;
    } else {
        _health += health;
    }
}

- (void) animate:(CCTime)dt
{
    NSString *path = [NSString stringWithFormat:@"%@-%d.png", _plane_name, frame_number];
    [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed:path]];
    frame_number++;
    if (frame_number == FRAMES + 1)
        frame_number=1;
    
}

@end