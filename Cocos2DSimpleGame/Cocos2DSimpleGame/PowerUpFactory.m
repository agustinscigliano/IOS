//
//  PowerUpFactory.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 3/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PowerUpFactory.h"

@implementation PowerUpFactory

+ (void) randomPowerUp:(CCPhysicsNode *)physics_world dropProbability: (int) drop_probability position: (CGPoint) position {
    int powerup_selector = arc4random() % POWERUPS_AMMOUNT;
    switch (powerup_selector) {
        case 0:
            [self healthPowerUp:physics_world dropProbability: drop_probability position:position];
            break;
        case 1:
            [self trippleShootPowerUp:physics_world dropProbability: drop_probability position:position];
            break;
        case 2:
            [self rapidFirePowerUp:physics_world dropProbability: drop_probability position:position];
            break;
        case 3:
            [self rocketPowerup:physics_world dropProbability: drop_probability position:position];
            break;
        case 4:
            [self shieldPowerup:physics_world dropProbability: drop_probability position:position];
            break;
        default:
            break;
    }
}

+ (void) healthPowerUp:(CCPhysicsNode *)physics_world dropProbability: (int) drop_probability position: (CGPoint) position {
    if (arc4random()%100 > drop_probability) {
        [physics_world addChild: [[Health alloc] initWithPosition:position]];
    }
}

+ (void) trippleShootPowerUp:(CCPhysicsNode *)physics_world dropProbability: (int) drop_probability position: (CGPoint) position {
    if (arc4random()%100 > drop_probability) {
        [physics_world addChild: [[TrippleShot alloc] initWithPosition:position]];
    }
}

+ (void)rapidFirePowerUp:(CCPhysicsNode *)physics_world dropProbability: (int) drop_probability position: (CGPoint) position {
    if (arc4random()%100 > drop_probability) {
        [physics_world addChild: [[RapidFire alloc] initWithPosition:position]];
    }
}

+ (void)rocketPowerup:(CCPhysicsNode *)physics_world dropProbability: (int) drop_probability position: (CGPoint) position {
    if (arc4random()%100 > drop_probability) {
        [physics_world addChild: [[RocketPowerup alloc] initWithPosition:position]];
    }
}

+ (void) shieldPowerup:(CCPhysicsNode *)physics_world dropProbability: (int) drop_probability position: (CGPoint) position {
    if (arc4random()%100 > drop_probability) {
        [physics_world addChild: [[ShieldPowerUp alloc] initWithPosition:position]];
    }
}

@end