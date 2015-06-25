//
//  DifficultyScene.h
//  Cocos2DSimpleGame
//
//  Created by Agustin Scigliano on 6/25/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"


@interface DifficultyScene : CCScene

+ (DifficultyScene *)sceneWithPlane:(NSString*) plane_name withDaytime: (int) daytime;
- (id)initWithPlaneName:(NSString*) plane_name withDaytime:(int) daytime;

@end