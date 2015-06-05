//
//  HelloWorldScene.m
//  Cocos2DSimpleGame
//
//  Created by Martin Walsh on 18/01/2014.
//  Copyright Razeware LLC 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"
#import "Monster.h"
#import "Player.h"
#import "Projectile.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    // 1
    Player *_player;
    CCPhysicsNode *_physicsWorld;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // 2
    self = [super init];
    if (!self) return(nil);
    
    // 3
    self.userInteractionEnabled = YES;
    
    [[OALSimpleAudio sharedInstance] playBg:@"background-music-aac.caf" loop:YES];
    
    // 4
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.6f green:0.6f blue:0.6f alpha:1.0f]];
    [self addChild:background];
    
    _physicsWorld = [CCPhysicsNode node];
    _physicsWorld.gravity = ccp(0,0);
    _physicsWorld.debugDraw = YES;
    _physicsWorld.collisionDelegate = self;
    [self addChild:_physicsWorld];
    
    // 5
    _player = [Player spriteWithImageNamed:@"p51-1.png"];
    _player.position  = ccp(self.contentSize.width/8, self.contentSize.height/2);
    [_physicsWorld addChild:_player];
    
    
    // 6
    //CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:1.5f angle:360];
    //[_player runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
    
    // 7
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    _label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", _score] fontName:@"Verdana-Bold" fontSize:15.0f];
    _label.positionType = CCPositionTypeNormalized;
    _label.position = ccp(0.15f, 0.95f); // Top Left of screen
    _label.color = [CCColor redColor];
    [self addChild:_label];

	return self;
}

- (void)addMonster:(CCTime)dt {
    [self addGhost:dt];
}

- (void)shootNormalBullet:(CCTime)dt {
    Projectile *projectile = [Projectile spriteWithImageNamed:@"projectile.png" position:_player.position];
    projectile.physicsBody.velocity = ccp(_player.bullet_speed + _player.physicsBody.velocity.x, 0);
    [_physicsWorld addChild:projectile];
}

- (void)addGhost:(CCTime)dt {
    Monster *monster = [Monster spriteWithImageNamed:@"monster.png"];
    
    // 1
    int minY = monster.contentSize.height / 2;
    int maxY = self.contentSize.height - monster.contentSize.height / 2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    monster.position = ccp(self.contentSize.width, randomY);
    //
    //    // 1
    //    int minY = monster.contentSize.height / 2;
    //    int maxY = self.contentSize.height - monster.contentSize.height / 2;
    //    int rangeY = maxY - minY;
    //    int randomY = (arc4random() % rangeY) + minY;
    //
    //    // 2

    [_physicsWorld addChild:monster];
    
    //
    //    // 3
    //    int minDuration = 2.0;
    //    int maxDuration = 4.0;
    //    int rangeDuration = maxDuration - minDuration;
    //    int randomDuration = (arc4random() % rangeDuration) + minDuration;
    //
    // 4
    //    CCAction *actionMove = [CCActionMoveTo actionWithDuration:randomDuration position:CGPointMake(-monster.contentSize.width/2, randomY)];
    //    CCAction *actionRemove = [CCActionRemove action];
    //    [monster runAction:[CCActionSequence actionWithArray:@[actionMove,actionRemove]]];
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Pr frame update is automatically enabled, if update is overridden
    
    [self schedule:@selector(addMonster:) interval:1.5];
    [self schedule:@selector(shootNormalBullet:) interval: _player.fire_rate];
    [self schedule:@selector(animatePlayer:) interval: 0.01];
}

- (void)animatePlayer:(CCTime) dt
{
    [_player animate:dt];
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [self move: touch withEvent: event];
    //[[OALSimpleAudio sharedInstance] playEffect:@"pew-pew-lei.caf"];
}

- (void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    [self move: touch withEvent: event];
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    _player.isTouched = NO;
}

- (void) move:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInNode:self];
    CGPoint offset = ccpSub(touchLocation, _player.position);
    float offsetModule = sqrt(offset.x*offset.x+offset.y*offset.y);
    float offsetModuleX = offset.x/offsetModule;
    float offsetModuleY = offset.y/offsetModule;
    CGPoint versorV = ccp(offsetModuleX, offsetModuleY);
    //Projectile *projectile = [Projectile spriteWithImageNamed:@"projectile.png" position:_player.position];
    //[_physicsWorld addChild:projectile];
    _player.velocity = versorV;
    _player.final_position = touchLocation;
    _player.isTouched = YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair monsterCollision:(CCNode *)monster projectileCollision:(CCNode *)projectile {
    [monster removeFromParent];
    [projectile removeFromParent];
    _score++;
    [_label setString:[NSString stringWithFormat:@"%d", _score]];
    return YES;
}

//- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair shellCollision:(CCNode *)shell projectileCollision:(CCNode *)projectile {
//    [shell removeFromParent];
//    [projectile removeFromParent];
//    return YES;
//}

//- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair monsterCollision:(CCNode *)monster playerCollision:(CCNode *)player
//{
//    [self goBackToMenu:nil];
//    return YES;
//}
//
//- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair shellCollision:(CCNode *)shell playerCollision:(CCNode *)player
//{
//    [self goBackToMenu:nil];
//    return YES;
//}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [self goBackToMenu:sender];
}

- (void)goBackToMenu:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end