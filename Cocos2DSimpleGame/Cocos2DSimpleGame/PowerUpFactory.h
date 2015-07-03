//
//  PowerUpFactory.h
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 3/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#ifndef Cocos2DSimpleGame_PowerUpFactory_h
#define Cocos2DSimpleGame_PowerUpFactory_h

#import "cocos2d.h"
#import "PowerUp.h"
#import "Constants.h"
#import "Health.h"
#import "TrippleShot.h"
#import "RapidFire.h"
#import "RocketPowerup.h"
#import "ShieldPowerUp.h"

@interface PowerUpFactory : NSObject

+ (void) randomPowerUp:(CCPhysicsNode *)physics_world dropProbability: (int) drop_probability position: (CGPoint) position;

@end

#endif
