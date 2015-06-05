//
//  misilee.m
//  Cocos2DSimpleGame
//
//  Created by Agustin Scigliano on 6/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import "cocos2d.h"
#import "Misile.h"

#define DAMAGE ((int) 5)

@implementation Misile

+ (Misile*) spriteWithImageNamed:(NSString *)name position: (CGPoint)position
{
    Misile *misile = [super spriteWithImageNamed:name];
    misile.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:misile.contentSize.width/2.0f andCenter:misile.anchorPointInPoints];
//    misile.physicsBody.collisionGroup = @"monsterGroup";
    misile.physicsBody.collisionCategories = @[@"misileCollision"];
    misile.physicsBody.collisionMask = @[@"monsterCollision"];
    misile.physicsBody.collisionType  = @"misileCollision";
    misile.position=position;
    misile.damage = DAMAGE;
    return misile;
}



@end
