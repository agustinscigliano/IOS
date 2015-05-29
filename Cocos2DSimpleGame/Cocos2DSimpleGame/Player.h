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
@property (nonatomic) CGPoint velocity;
@property (nonatomic) CGPoint final_position;
@property (nonatomic) BOOL isTouched;

+ (Player*) spriteWithImageNamed:(NSString*)name;

@end
