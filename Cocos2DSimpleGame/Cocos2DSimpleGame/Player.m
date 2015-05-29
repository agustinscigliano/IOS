//
//  Player.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@implementation Player

+ (Player*) spriteWithImageNamed:(NSString *)name
{
    Player *player = [super spriteWithImageNamed:name];
    player.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, player.contentSize} cornerRadius:0]; // 1
    player.physicsBody.collisionGroup = @"playerGroup"; // 2
    player.physicsBody.collisionType = @"playerCollision";
    return player;
}

-(void) update:(CCTime)delta
{
    if(self.isTouched)
    {
        [self setPosition:ccp(self.position.x+_velocity.x*100*delta, self.position.y+_velocity.y*100*delta)];
        
        
    }
}

@end