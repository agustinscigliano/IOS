//
//  EnemyFactory.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#include "EnemyPlane_1.h"
#include "GameScene.h"

@interface EnemyFactory : NSObject

+ (EnemyPlane_1 *)createEnemyPlane1: (GameScene *) scene;

@end
