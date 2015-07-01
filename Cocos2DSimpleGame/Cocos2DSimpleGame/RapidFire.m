//
//  RapidFire.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RapidFire.h"
#import "Constants.h"

@implementation RapidFire

- (id) initWithPosition: (CGPoint) position {
    self = [super initWithImageNamed:@"rapid-fire.png"];
    [super initializeWithPosition: position];
    self.physicsBody.collisionCategories = @[RAPID_FIRE_COLLISION];
    self.physicsBody.collisionType  = RAPID_FIRE_COLLISION;
    self.scale = RAPID_FIRE_SCALE;
    return self;
}

@end
