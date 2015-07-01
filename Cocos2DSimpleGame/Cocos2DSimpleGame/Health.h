//
//  Health.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#import "PowerUp.h"

@interface Health : PowerUp

@property (nonatomic) int health;

- (id) initWithPosition: (CGPoint) position;

@end
