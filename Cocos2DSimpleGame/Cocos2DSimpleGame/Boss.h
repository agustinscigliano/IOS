//
//  Boss.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 2/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//


#import "cocos2d.h"
#include "Constants.h"

@interface Boss : CCSprite

@property (nonatomic) int score;

- (id) initWithGameScene: (CCScene*) gs withDifficulty:(int)difficulty;

@end