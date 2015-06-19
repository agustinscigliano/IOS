//
//  IntroScene.m
//  Cocos2DSimpleGame
//
//  Created by Martin Walsh on 18/01/2014.
//  Copyright Razeware LLC 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "PlaneSelectionScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
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
    
    // Spinning scene button
    CCButton *spinningButton = [CCButton buttonWithTitle:@"Start" fontName:@"Courier New" fontSize:24.0f];
    spinningButton.positionType = CCPositionTypeNormalized;
    spinningButton.position = ccp(0.5f, 0.35f);
    [spinningButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:spinningButton];
	
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[PlaneSelectionScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}

// -----------------------------------------------------------------------
@end
