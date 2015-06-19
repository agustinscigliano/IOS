//
//  EnemyBullet.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import "cocos2d.h"
#import "EnemyBullet.h"
#import "Constants.h"

#define DAMAGE ((int) 5)

@implementation EnemyBullet

-(id)initWithPosition: (CGPoint)position {
    self = [super initWithImageNamed:@"bullet.png"];
    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
    self.physicsBody.collisionCategories = @[@"enemyBulletCollision"];
    self.physicsBody.collisionMask = @[ENEMY_COLLISION];
    self.physicsBody.collisionType  = @"enemyBulletCollision";
    self.physicsBody.velocity = ccp(-DEFAULT_BULLET_SPEED, 0);
    self.scaleX = BULLET_SCALE_X;
    self.scaleY = BULLET_SCALE_Y;
    self.position = position;
    _damage = DAMAGE;
    return self;
}

- (void) update:(CCTime) delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
}

@end
