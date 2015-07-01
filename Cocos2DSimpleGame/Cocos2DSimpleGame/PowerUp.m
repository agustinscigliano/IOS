//
//  PowerUp.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 1/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PowerUp.h"

@implementation PowerUp

- (void) update:(CCTime)delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
}

@end