//
//  Cloud.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 19/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cloud.h"
#import "Constants.h"
#import "cocos2d-ui.h"

@implementation Cloud

+(CCSprite*) initCloud {
    int cloud_number = (arc4random() % CLOUDS_AMOUNT) + 1;
    NSString *cloud_name = [NSString stringWithFormat:@"cloud-%d.png", cloud_number];
    CCSprite *cloud = [[CCSprite alloc] initWithImageNamed: cloud_name];
    cloud.scale = 0.2f;
    return cloud;
}

- (void) update:(CCTime)delta {
    if (self.position.x < -self.contentSize.width) {
        [self removeFromParent];
    }
}

@end