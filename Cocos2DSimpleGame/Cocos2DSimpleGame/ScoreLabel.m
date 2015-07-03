//
//  ScoreDamageLabel.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 3/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreLabel.h"

@implementation ScoreLabel

+ (void) label:(GameScene *)game_scene position:(CGPoint)position value: (int) value {
    ScoreLabel *label = [super labelWithString:[NSString stringWithFormat:@"%d", value] fontName:@"Courier New" fontSize:10.0f];
    label.position = position;
    label.color = [CCColor whiteColor];
    [label schedule:@selector(destroy:) interval:1 repeat:0 delay:1.5];
    [game_scene addChild:label];
}

- (void) destroy:(CCTime)dt {
    [self removeFromParent];
}

@end