//
//  IntroScene.m
//  Cocos2DSimpleGame
//
//  Created by Martin Walsh on 18/01/2014.
//  Copyright Razeware LLC 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "IntroScene.h"
#import "PlaneSelectionScene.h"


@implementation IntroScene

+ (IntroScene *)scene {
	return [[self alloc] init];
}

- (id)init {
    self = [super init];
    if (!self) return(nil);
    
    //Background image
    CCSprite *clouds = [[CCSprite alloc] initWithImageNamed:@"clouds.png"];
    clouds.scale = 0.5f;
    clouds.positionType = CCPositionTypeNormalized;
    clouds.position = ccp(0.5f, 0.5f);
    [self addChild:clouds];
    
    // 1943 Logo
    CCSprite *logo = [[CCSprite alloc] initWithImageNamed:@"1943.png"];
    logo.scale = 0.5f;
    logo.positionType = CCPositionTypeNormalized;
    logo.position = ccp(0.5f, 0.75f);
    [self addChild:logo];
    
    //p51-mustang logo
    CCSprite *p51_logo = [[CCSprite alloc] initWithImageNamed:@"p51-logo.png"];
    p51_logo.scale = 0.5f;
    p51_logo.positionType = CCPositionTypeNormalized;
    p51_logo.position = ccp(0.15f, 0.75f);
    [self addChild:p51_logo];
    
    //Start game button
    CCButton *startButton = [CCButton buttonWithTitle:@"START" fontName:@"Courier New" fontSize:24.0f];
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5f, 0.35f);
    [startButton setTarget:self selector:@selector(onStartGameButtonClicked:)];
    [self addChild:startButton];
    
    CCLabelTTF* created_by_label = [CCLabelTTF labelWithString:@"Created by Germán Romarión & Agustín Scigliano - ITBA - 2015" fontName:@"Courier New" fontSize:12.0f];
    created_by_label.positionType = CCPositionTypeNormalized;
    created_by_label.position = ccp(0.5f, 0.05f);
    created_by_label.color = [CCColor whiteColor];
    [self addChild:created_by_label];
    
    [[OALSimpleAudio sharedInstance] playBg:@"game-menu-music.mp3" loop:YES];
    
	return self;
}

- (void)onStartGameButtonClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[PlaneSelectionScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}
@end
