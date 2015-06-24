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
#import "Constants.h"

#define DAMAGE ((int) 10)

@implementation Misile

-(id)initWithPosition: (CGPoint)position {
    self = [super initWithImageNamed:MISSILE_IMAGE];
    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
    self.physicsBody.collisionCategories = @[MISSILE_COLLISION];
    self.physicsBody.collisionMask = @[ENEMY_COLLISION];
    self.physicsBody.collisionType  = MISSILE_COLLISION;
    self.physicsBody.velocity = ccp(-MISILE_SPEED-ENEMY_PLANE_3_SPEED, 0);
    self.scaleX = MISILE_SCALE_X;
    self.scaleY = MISILE_SCALE_Y;
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
