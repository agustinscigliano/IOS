//
//  Projectile.m
//  Cocos2DSimpleGame
//
//  Created by Agustin Scigliano on 5/29/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import "cocos2d.h"
#import "Projectile.h"

#define DAMAGE ((int) 5)

@implementation Projectile

+ (Projectile*) spriteWithImageNamed:(NSString *)name position: (CGPoint)position
{
    Projectile *projectile = [super spriteWithImageNamed:name];
    projectile.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:projectile.contentSize.width/2.0f andCenter:projectile.anchorPointInPoints];

    
    projectile.physicsBody.collisionMask = @[@"monsterCollision"];
//    projectile.physicsBody.collisionGroup = @"playerGroup";
    projectile.physicsBody.collisionCategories = @[@"projectileCollision"];
    projectile.physicsBody.collisionType  = @"projectileCollision";
    projectile.position=position;
    projectile.damage = DAMAGE;
    return projectile;
}



@end

