//
//  Player.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"

@interface Player : CCSprite

@property (nonatomic) int health;

+ (Player*) spriteWithImageNamed:(NSString*)name;

@end
