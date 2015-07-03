//
//  YouWonScene.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 2/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroScene.h"
#import "YouWonScene.h"

@implementation YouWonScene

+ (YouWonScene *)sceneWithFinalScore:(int) final_score {
    return [[self alloc] initWithFinalScore: final_score];
}

- (id)initWithFinalScore:(int) final_score {
    self = [super init];
    if (!self) return(nil);
    
    // Game over
    CCLabelTTF *game_over = [CCLabelTTF labelWithString:@"YOU WON" fontName:@"Courier New" fontSize:24.0f];
    game_over.positionType = CCPositionTypeNormalized;
    game_over.position = ccp(0.5f, 0.75f);
    [self addChild:game_over];
    
    // Final score
    NSString *score = [NSString stringWithFormat:@"Final score: %d", final_score];
    CCLabelTTF *score_label = [CCLabelTTF labelWithString:score fontName:@"Courier New" fontSize:20.0f];
    score_label.positionType = CCPositionTypeNormalized;
    score_label.position = ccp(0.5f, 0.55f);
    [self addChild:score_label];
    
    //Back to main menu button
    CCButton *startButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Courier New" fontSize:24.0f];
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5f, 0.35f);
    [startButton setTarget:self selector:@selector(onBackToMenuClicked:)];
    [self addChild:startButton];
    
    [[OALSimpleAudio sharedInstance] playBg:@"ending.mp3" loop:NO];
    
    return self;
}

- (void)onBackToMenuClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}

@end

