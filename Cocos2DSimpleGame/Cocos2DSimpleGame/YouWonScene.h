//
//  YouWonScene.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 2/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface YouWonScene : CCScene

+ (YouWonScene *)sceneWithFinalScore:(int) final_score;
- (id)initWithFinalScore:(int) final_score;

@end