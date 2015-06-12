//
//  EnemyPlane_1.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EnemyPlane_1.h"

@implementation EnemyPlane_1 {
    int frame_number;
}

- (id) init {
    self = [super init];
    if (self) {
        self = [super initWithImageNamed: ENEMY_PLANE_1_IMAGE];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[ENEMY_COLLISION];
        self.physicsBody.collisionMask = @[PROJECTILE_COLLISION];
        self.physicsBody.collisionType  = ENEMY_COLLISION;
        self.physicsBody.mass = 100;
        self.physicsBody.friction = 0;
        frame_number=1;
    }
    return self;
}

- (void) animate:(CCTime) dt {
    NSString *frame_path = [NSString stringWithFormat:@"bf-109e-%d.png", frame_number];
    [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: frame_path]];
    frame_number++;
    if (frame_number == MAX_FRAMES_FOR_PLANES)
        frame_number = 1;
}

@end