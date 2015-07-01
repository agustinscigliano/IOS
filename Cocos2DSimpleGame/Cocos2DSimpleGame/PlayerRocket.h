//
//  PlayerRocket.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 1/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"

@interface PlayerRocket : CCSprite

@property (nonatomic) int damage;

- (id)initWithPosition: (CGPoint)position screenSize: (int) screen_size;

@end