//
//  GameOver.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface GameOver : CCScene

+ (GameOver *)sceneWithFinalScore:(int) final_score;
- (id)initWithFinalScore:(int) final_score;

@end