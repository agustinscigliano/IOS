//
//  Health.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Health.h"
#import "Constants.h"

@implementation Health

- (id) initWithPosition: (CGPoint) position {
    self = [super initWithImageNamed:@"health.png"];
    [super initializeWithPosition: position];
    self.physicsBody.collisionCategories = @[HEALTH_COLLISION];
    self.physicsBody.collisionType  = HEALTH_COLLISION;
    self.health = HEALTH_VALUE;
    self.scale = HEALTH_SCALE;
    return self;
}

@end