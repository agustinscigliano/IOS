//
//  DifficultyScene.m
//  Cocos2DSimpleGame
//
//  Created by Agustin Scigliano on 6/25/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DifficultyScene.h"
#import "SelectDaytimeScene.h"
#import "GameScene.h"
#import "Constants.h"

@implementation DifficultyScene{
    NSString* _plane_name;
    int _dayTime;
}

+ (DifficultyScene *)sceneWithPlane:(NSString*) plane_name withDaytime:(int) daytime {
    return [[self alloc] initWithPlaneName: plane_name withDaytime:daytime];
}

- (id)initWithPlaneName:(NSString*) plane_name withDaytime:(int)daytime{
    self = [super init];
    if (!self) return(nil);
    _plane_name = plane_name;
    _dayTime = daytime;
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.75f blue:1.0f alpha:1.0f]];
    [self addChild:background];
    
    // Selection Difficulty title
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"SELECT DIFFICULTY" fontName:@"Courier New" fontSize:20.0];
    title.positionType = CCPositionTypeNormalized;
    title.position = ccp(0.5f, 0.9f);
    [self addChild:title];
    
    // Easy icon
    CCSpriteFrame *easy = [CCSpriteFrame frameWithImageNamed:@"easy.png"];
    CCButton *easyButton = [CCButton buttonWithTitle:nil spriteFrame:easy];
    easyButton.scale = EASY_ICON_SCALE;
    easyButton.positionType = CCPositionTypeNormalized;
    easyButton.position = ccp(0.15f, 0.75f);
    [easyButton setTarget:self selector:@selector(onEasyButtonClicked:)];
    [self addChild:easyButton];
    
    // Easy description
    NSString *easy_description = @"Beginners who don't like challenges and are cowards.";
    CGSize rect_size = CGRectMake(0.0, 0.0, 400, 100).size;
    CCLabelTTF *easy_description_label = [CCLabelTTF labelWithString:easy_description fontName:@"Courier New" fontSize:10.0 dimensions:rect_size];
    easy_description_label.positionType = CCPositionTypeNormalized;
    easy_description_label.position = ccp(0.65f, 0.65f);
    [self addChild:easy_description_label];
    
    // Easy name
    CCLabelTTF *easy_name = [CCLabelTTF labelWithString:@"Easy" fontName:@"Courier New" fontSize:12.0];
    easy_name.positionType = CCPositionTypeNormalized;
    easy_name.position = ccp(0.15f, 0.65f);
    [self addChild:easy_name];
    
    // Medium icon
    CCSpriteFrame *medium = [CCSpriteFrame frameWithImageNamed:@"medium.png"];
    CCButton *mediumButton = [CCButton buttonWithTitle:nil spriteFrame:medium];
    mediumButton.scale = MEDIUM_ICON_SCALE;
    mediumButton.positionType = CCPositionTypeNormalized;
    mediumButton.position = ccp(0.15f, 0.5f);
    [mediumButton setTarget:self selector:@selector(onMediumButtonClicked:)];
    [self addChild:mediumButton];
    
    // Medium description
    NSString *medium_description = @"What normal people would play.";
    CCLabelTTF *medium_description_label = [CCLabelTTF labelWithString:medium_description fontName:@"Courier New" fontSize:10.0 dimensions:rect_size];
    medium_description_label.positionType = CCPositionTypeNormalized;
    medium_description_label.position = ccp(0.65f, 0.4f);
    [self addChild:medium_description_label];
    
    // Medium name
    CCLabelTTF *medium_name = [CCLabelTTF labelWithString:@"Medium" fontName:@"Courier New" fontSize:12.0];
    medium_name.positionType = CCPositionTypeNormalized;
    medium_name.position = ccp(0.15f, 0.4f);
    [self addChild:medium_name];
    
    // INSANE icon
    CCSpriteFrame *insane = [CCSpriteFrame frameWithImageNamed:@"insane.png"];
    CCButton *insaneButton = [CCButton buttonWithTitle:nil spriteFrame:insane];
    insaneButton.scale = INSANE_ICON_SCALE;
    insaneButton.positionType = CCPositionTypeNormalized;
    insaneButton.position = ccp(0.15f, 0.25f);
    [insaneButton setTarget:self selector:@selector(onInsaneButtonClicked:)];
    [self addChild:insaneButton];
    
    // INSANE description
    NSString *insane_description = @"Don't you dare..";
    CCLabelTTF *insane_description_label = [CCLabelTTF labelWithString:insane_description fontName:@"Courier New" fontSize:10.0 dimensions:rect_size];
    insane_description_label.positionType = CCPositionTypeNormalized;
    insane_description_label.position = ccp(0.65f, 0.15f);
    [self addChild:insane_description_label];
    
    // Insane name
    CCLabelTTF *insane_name = [CCLabelTTF labelWithString:@"INSANE" fontName:@"Courier New" fontSize:12.0];
    insane_name.positionType = CCPositionTypeNormalized;
    insane_name.position = ccp(0.15f, 0.15f);
    [self addChild:insane_name];
    
    return self;

}

- (void)onEasyButtonClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[GameScene sceneWithPlane: _plane_name withDaytime: _dayTime withDifficulty: EASY] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}

- (void)onMediumButtonClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[GameScene sceneWithPlane: _plane_name withDaytime: _dayTime withDifficulty: MEDIUM] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}

- (void)onInsaneButtonClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[GameScene sceneWithPlane: _plane_name withDaytime: _dayTime withDifficulty: INSANE] withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}



@end