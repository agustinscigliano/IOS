//
//  ScoreDamageLabel.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 3/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#ifndef Cocos2DSimpleGame_ScoreDamageLabel_h
#define Cocos2DSimpleGame_ScoreDamageLabel_h

#import "cocos2d.h"
#import "GameScene.h"
#import "Constants.h"

@interface ScoreLabel : CCLabelTTF

+ (void) label:(GameScene *)game_scene position:(CGPoint)position value: (int) value;

@end

#endif
