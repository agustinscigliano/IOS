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
    self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:self.contentSize.width/2.0f andCenter:self.anchorPointInPoints];
    self.physicsBody.collisionCategories = @[HEALTH_COLLISION];
    self.physicsBody.collisionMask = @[ENEMY_COLLISION, MISSILE_COLLISION, BULLET_COLLISION, ENEMY_BULLET_COLLISION];
    self.physicsBody.collisionType  = HEALTH_COLLISION;
    self.physicsBody.velocity = ccp(-100, 0);
    self.position = position;
    self.health = HEALTH_VALUE;
    self.scale = HEALTH_SCALE;
    return self;
}

-(void) update:(CCTime)delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
}

@end