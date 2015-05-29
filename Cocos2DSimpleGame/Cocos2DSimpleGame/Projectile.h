//
//  Proyectile.h
//  Cocos2DSimpleGame
//
//  Created by Agustin Scigliano on 5/29/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"

@interface Projectile : CCSprite


+ (Projectile*) spriteWithImageNamed:(NSString*)name position:(CGPoint)position;

@end
