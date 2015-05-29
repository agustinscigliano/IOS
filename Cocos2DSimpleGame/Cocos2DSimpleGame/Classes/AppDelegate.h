//
//  AppDelegate.h
//  Cocos2DSimpleGame
//
//  Created by Martin Walsh on 18/01/2014.
//  Copyright Razeware LLC 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"

@interface AppDelegate : CCAppDelegate

@property (strong, nonatomic) CCAction* action;

- (void) nombre;
- (AppDelegate*) nombre:(float)var1 yOtraVariable:(int)var2 yTambienOtraVariable:(NSString*)var3;

@end
