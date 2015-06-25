//
//  SelectDaytimeScene.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 24/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SelectDaytimeScene.h"
#import "GameScene.h"
#import "Constants.h"
#import "DifficultyScene.h"

@implementation SelectDaytimeScene {
    NSString* _plane_name;
}

+ (SelectDaytimeScene *)sceneWithPlane:(NSString*) plane_name {
    return [[self alloc] initWithPlaneName: plane_name];
}

- (id)initWithPlaneName:(NSString*) plane_name {
    self = [super init];
    if (!self) return(nil);
    _plane_name = plane_name;
    
    // Selection plane title
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"SELECT A DAYTIME" fontName:@"Courier New" fontSize:20.0];
    title.positionType = CCPositionTypeNormalized;
    title.position = ccp(0.5f, 0.9f);
    [self addChild:title];
    
    // Day icon
    CCSpriteFrame *day = [CCSpriteFrame frameWithImageNamed:@"day.png"];
    CCButton *dayButton = [CCButton buttonWithTitle:nil spriteFrame:day];
    dayButton.scale = DAY_ICON_SCALE;
    dayButton.positionType = CCPositionTypeNormalized;
    dayButton.position = ccp(0.15f, 0.75f);
    [dayButton setTarget:self selector:@selector(onDayButtonClicked:)];
    [self addChild:dayButton];
    
    // Day description
    NSString *p51_description = @"Clear blue sky. Just the perfect kind of daytime to kill some nazis.";
    CGSize rect_size = CGRectMake(0.0, 0.0, 400, 100).size;
    CCLabelTTF *p51_description_label = [CCLabelTTF labelWithString:p51_description fontName:@"Courier New" fontSize:10.0 dimensions:rect_size];
    p51_description_label.positionType = CCPositionTypeNormalized;
    p51_description_label.position = ccp(0.65f, 0.65f);
    [self addChild:p51_description_label];
    
    // Day name
    CCLabelTTF *p51_plane_name = [CCLabelTTF labelWithString:@"Day" fontName:@"Courier New" fontSize:12.0];
    p51_plane_name.positionType = CCPositionTypeNormalized;
    p51_plane_name.position = ccp(0.15f, 0.65f);
    [self addChild:p51_plane_name];
    
    // Sunset icon
    CCSpriteFrame *sunset = [CCSpriteFrame frameWithImageNamed:@"sunset.png"];
    CCButton *sunsetButton = [CCButton buttonWithTitle:nil spriteFrame:sunset];
    sunsetButton.scale = SUNSET_ICON_SCALE;
    sunsetButton.positionType = CCPositionTypeNormalized;
    sunsetButton.position = ccp(0.15f, 0.5f);
    [sunsetButton setTarget:self selector:@selector(onSunsetButtonClicked:)];
    [self addChild:sunsetButton];
    
    // Sunset description
    NSString *spitfire_description = @"It's getting kinda late. Let's shoot down some planes!";
    CCLabelTTF *spitfire_description_label = [CCLabelTTF labelWithString:spitfire_description fontName:@"Courier New" fontSize:10.0 dimensions:rect_size];
    spitfire_description_label.positionType = CCPositionTypeNormalized;
    spitfire_description_label.position = ccp(0.65f, 0.4f);
    [self addChild:spitfire_description_label];
    
    // Sunset name
    CCLabelTTF *spitfire_plane_name = [CCLabelTTF labelWithString:@"Sunset" fontName:@"Courier New" fontSize:12.0];
    spitfire_plane_name.positionType = CCPositionTypeNormalized;
    spitfire_plane_name.position = ccp(0.15f, 0.4f);
    [self addChild:spitfire_plane_name];
    
    // Night icon
    CCSpriteFrame *night = [CCSpriteFrame frameWithImageNamed:@"night.png"];
    CCButton *nightButton = [CCButton buttonWithTitle:nil spriteFrame:night];
    nightButton.scale = NIGHT_ICON_SCALE;
    nightButton.positionType = CCPositionTypeNormalized;
    nightButton.position = ccp(0.15f, 0.25f);
    [nightButton setTarget:self selector:@selector(onNightButtonClicked:)];
    [self addChild:nightButton];
    
    // Night description
    NSString *hurricane_description = @"Bedtime you say!? Nahhh, I wanna fight!";
    CCLabelTTF *hurricane_description_label = [CCLabelTTF labelWithString:hurricane_description fontName:@"Courier New" fontSize:10.0 dimensions:rect_size];
    hurricane_description_label.positionType = CCPositionTypeNormalized;
    hurricane_description_label.position = ccp(0.65f, 0.15f);
    [self addChild:hurricane_description_label];
    
    // Night name
    CCLabelTTF *hurricane_plane_name = [CCLabelTTF labelWithString:@"Night" fontName:@"Courier New" fontSize:12.0];
    hurricane_plane_name.positionType = CCPositionTypeNormalized;
    hurricane_plane_name.position = ccp(0.15f, 0.15f);
    [self addChild:hurricane_plane_name];
    
    return self;
}

- (void)onDayButtonClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[DifficultyScene sceneWithPlane: _plane_name withDaytime: DAY]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}

- (void)onSunsetButtonClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[DifficultyScene sceneWithPlane: _plane_name withDaytime: SUNSET]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}

- (void)onNightButtonClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[DifficultyScene sceneWithPlane: _plane_name withDaytime: NIGHT]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}

@end
