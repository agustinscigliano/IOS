//
//  GameScene.h
//  Cocos2DSimpleGame
//
//  Created by Martin Walsh on 18/01/2014.
//  Copyright Razeware LLC 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface GameScene : CCScene <CCPhysicsCollisionDelegate>

// -----------------------------------------------------------------------

@property (nonatomic) int score;
@property (nonatomic) CCLabelTTF* score_label;
@property (nonatomic) CCLabelTTF* fuselage_label;

@property (nonatomic, strong) CCPhysicsNode* physicsWorld;

+ (GameScene *)sceneWithPlane:(NSString*) plane_name;

// -----------------------------------------------------------------------
@end