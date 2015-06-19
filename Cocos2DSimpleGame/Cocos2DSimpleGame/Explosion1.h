//
//  Explosion1.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#ifndef Cocos2DSimpleGame_Explosion1_h
#define Cocos2DSimpleGame_Explosion1_h

#import "cocos2d.h"

@interface Explosion1 : CCSprite

@property (nonatomic) int damage;

- (id) initWithPosition:(CGPoint)position withScale: (float) scale withVelocityX: (int) velocity_x;
- (void) animate: (CCTime) dt;

@end

#endif
