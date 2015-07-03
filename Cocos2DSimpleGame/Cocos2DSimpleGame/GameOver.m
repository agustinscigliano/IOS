//
//  GameOver.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroScene.h"
#import "GameOver.h"

@implementation GameOver

+ (GameOver *)sceneWithFinalScore:(int) final_score isGameOver:(BOOL)is_game_over {
    return [[self alloc] initWithFinalScore: final_score isGameOver: is_game_over];
}

- (id)initWithFinalScore:(int) final_score isGameOver: (BOOL) is_game_over {
    self = [super init];
    if (!self) return(nil);
    
    // Title
    NSString *title = @"";
    NSString *song_name = @"";
    if (is_game_over) {
        title = @"GAME OVER";
        song_name = @"game-over.mp3";
    } else {
        title = @"YOU WON";
        song_name = @"ending.mp3";
    }
    CCLabelTTF *game_over = [CCLabelTTF labelWithString:title fontName:@"Courier New" fontSize:24.0f];
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
    
    [[OALSimpleAudio sharedInstance] playBg:song_name loop:NO];
    
    return self;
}

- (void)onBackToMenuClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}

@end
