//
//  Monster.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 20/3/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import "cocos2d.h"
#import "Monster.h"
#import "Shell.h"
#import "Phantom.h"
#import "Misile.h"
#import "HelloWorldScene.h"

#define DEFAULT_BULLET_SPEED ((int) 400)


@implementation Monster

+ (Monster*) spriteWithImageNamed:(NSString *)name
{
    Monster *monster = [super spriteWithImageNamed:name];
    monster.shell_radius = 40;
    monster.bullet_speed = -DEFAULT_BULLET_SPEED;
    Phantom *phantom_node = [[Phantom alloc] init];
//    [phantom_node setAnchorPoint:ccp(monster.contentSize.width/2, monster.contentSize.height/2)];
    [monster addShells:phantom_node];
    [monster addChild:phantom_node];
    [phantom_node runAction:[CCActionRepeatForever actionWithAction:[CCActionRotateBy actionWithDuration:0.1 angle:15]]];
    monster.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, monster.contentSize} cornerRadius:0];
    monster.physicsBody.collisionCategories = @[@"monsterCollision"];
    monster.physicsBody.collisionMask = @[@"projectileCollision"];
//    monster.physicsBody.collisionGroup = @"monsterGroup";
    monster.physicsBody.collisionType  = @"monsterCollision";
    return monster;
}

- (void) update:(CCTime)delta
{
    int step = 100;
    [self setPosition: ccp(self.position.x - step*delta, self.position.y - _y_value*delta)];
    
    if (arc4random() % 10 == 0) {
        int lowerBound = -step;
        int upperBound = step;
        _y_value = lowerBound + arc4random() % (upperBound - lowerBound);
    }
    if (arc4random()%100 > 98) {
        [self shootEnemy:delta];
    }
    
    
    
}

-(void)shootEnemy:(CCTime)dt{
    Misile *misile = [Misile spriteWithImageNamed:@"misile.png" position:self.position];
    misile.physicsBody.velocity = ccp(self.bullet_speed,0);
    
    CCPhysicsNode* pw = ((HelloWorldScene*)[CCDirector sharedDirector].runningScene).physicsWorld;
    [pw addChild:misile];
}


- (void) addShells:(CCNode*) phantom_node
{
    [self addUpperShellToNode:phantom_node];
    [self addLeftBottomShellToNode:phantom_node];
    [self addRightBottomShellToNode:phantom_node];
}

- (void) addUpperShellToNode:(CCNode*)node;
{
    CCSprite *shell = [Shell spriteWithImageNamed:@"shell.png"];
    [shell setPosition: ccp(self.contentSize.width/2, self.contentSize.height + _shell_radius)];
    [node addChild: shell];
}

- (void) addLeftBottomShellToNode:(CCNode*)node;
{
    CCSprite *shell = [Shell spriteWithImageNamed:@"shell.png"];
    [shell setPosition: ccp(self.contentSize.width/2 - _shell_radius, self.contentSize.height - _shell_radius)];
    [node addChild: shell];
}

- (void) addRightBottomShellToNode:(CCNode*)node;
{
    CCSprite *shell = [Shell spriteWithImageNamed:@"shell.png"];
    [shell setPosition: ccp(self.contentSize.width/2 + _shell_radius, self.contentSize.height - _shell_radius)];
    [node addChild: shell];
}

@end