//
//  GameScene.h
//  Cocos2DSimpleGame
//
//  Created by Martin Walsh on 18/01/2014.
//  Copyright Razeware LLC 2014. All rights reserved.
//

#ifndef GAME_SCENE_H
#define GAME_SCENE_H

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface GameScene : CCScene <CCPhysicsCollisionDelegate>

@property (nonatomic) int score;
@property (nonatomic) int level;
@property (nonatomic) int difficulty;
@property (nonatomic) CCLabelTTF* score_label;
@property (nonatomic) CCLabelTTF* fuselage_label;
@property (nonatomic) CCLabelTTF* level_label;
@property (nonatomic) CCLabelTTF* credits_label;

@property (nonatomic, strong) CCPhysicsNode* physicsWorld;

+ (GameScene *)sceneWithPlane:(NSString*) plane_name withDaytime: (int) daytime withDifficulty: (int) difficulty;

@end

#endif