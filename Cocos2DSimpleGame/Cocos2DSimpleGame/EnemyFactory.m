//
//  EnemyFactory.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "EnemyFactory.h"


@implementation EnemyFactory

+ (EnemyPlane_1 *)createEnemyPlane1: (HelloWorldScene *) scene {
    EnemyPlane_1 *enemy_plane_1 = [[EnemyPlane_1 alloc] init];
    return enemy_plane_1;
}

@end