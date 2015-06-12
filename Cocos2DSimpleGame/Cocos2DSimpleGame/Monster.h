//
//  Monster.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 20/3/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"

@interface Monster : CCSprite

@property (nonatomic) int y_value;
@property (nonatomic) int shell_radius;
@property (nonatomic) int bullet_speed;
+ (Monster*) spriteWithImageNamed:(NSString*)name;

@end
