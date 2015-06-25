//
//  SelectDaytimeScene.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 24/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface SelectDaytimeScene : CCScene

+ (SelectDaytimeScene *)sceneWithPlane:(NSString*) plane_name;
- (id)initWithPlaneName:(NSString*) plane_name;

@end