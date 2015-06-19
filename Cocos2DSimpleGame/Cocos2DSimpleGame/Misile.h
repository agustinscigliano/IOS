//
//  misile.h
//  Cocos2DSimpleGame
//
//  Created by Agustin Scigliano on 6/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"

@interface Misile : CCSprite

@property (nonatomic) int damage;

- (id) initWithPosition:(CGPoint)position;

@end
