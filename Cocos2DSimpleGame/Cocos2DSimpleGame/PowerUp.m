//
//  PowerUp.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 1/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PowerUp.h"

@implementation PowerUp

- (id) initializeWithPosition: (CGPoint) position {
    self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:self.contentSize.width/2.0f andCenter:self.anchorPointInPoints];
    self.physicsBody.velocity = ccp(-100, 0);
    self.physicsBody.sensor = YES;
    self.position = position;
    return self;
}

- (void) update:(CCTime)delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
}

@end