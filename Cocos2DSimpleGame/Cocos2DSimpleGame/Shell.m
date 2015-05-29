//
//  Shell.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 24/3/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shell.h"

@implementation Shell

+ (Shell*) spriteWithImageNamed:(NSString *)name
{
    Shell *shell = [super spriteWithImageNamed:name];
//    shell.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:shell.contentSize.width/2.0f andCenter:shell.anchorPointInPoints];
    shell.physicsBody.collisionGroup = @"shellGroup";
    shell.physicsBody.collisionType  = @"shellCollision";
    return shell;
}

- (void) update:(CCTime)delta
{
//    [self setPosition:ccp(self.position.x - 100*delta, self.position.y - 100*delta)];
}

@end