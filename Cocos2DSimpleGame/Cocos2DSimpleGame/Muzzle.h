//
//  Muzzle.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#ifndef Cocos2DSimpleGame_Muzzle_h
#define Cocos2DSimpleGame_Muzzle_h

#import "cocos2d.h"

@interface Muzzle : CCSprite

- (id) initWithPosition: (CGPoint) position;
- (void) animate: (CCTime) dt;

@end

#endif
