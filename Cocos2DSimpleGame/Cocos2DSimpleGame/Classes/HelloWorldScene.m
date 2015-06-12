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
#import "EnemyPlane_1.h"
#import "Player.h"
#import "Projectile.h"
#import "Misile.h"

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    // 1
    Player *_player;
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
    
    self.physicsWorld = [CCPhysicsNode node];
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

- (void)addEnemy:(CCTime)dt {
    [self addPlane:dt];
}

- (void)shoot:(CCTime)dt {
        [self shootNormalBullet:dt who:_player where:_player.bullet_speed + _player.physicsBody.velocity.x];
}


- (void)shootNormalBullet:(CCTime)dt who:(CCSprite*)sp where: (int) bs {
    Projectile *projectile = [Projectile spriteWithImageNamed:@"projectile.png" position:sp.position];
    projectile.physicsBody.velocity = ccp(bs, 0);
    [_physicsWorld addChild:projectile];
}

- (void)addPlane:(CCTime)dt {
    EnemyPlane_1 *enemy_plane1 = [[EnemyPlane_1 alloc] init];
    
    // 1
    int minY = enemy_plane1.contentSize.height / 2;
    int maxY = self.contentSize.height - enemy_plane1.contentSize.height / 2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    enemy_plane1.position = ccp(self.contentSize.width, randomY);
    //
    //    // 1
    //    int minY = monster.contentSize.height / 2;
    //    int maxY = self.contentSize.height - monster.contentSize.height / 2;
    //    int rangeY = maxY - minY;
    //    int randomY = (arc4random() % rangeY) + minY;
    //
    //    // 2
    [_physicsWorld addChild:enemy_plane1];
    
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
    
    [self schedule:@selector(addEnemy:) interval:1.5];
    [self schedule:@selector(shoot:) interval: _player.fire_rate];
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

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair enemyCollision:(CCNode *)enemy projectileCollision:(CCNode *)projectile {
    [enemy removeFromParent];
    [projectile removeFromParent];
    _score++;
    [_label setString:[NSString stringWithFormat:@"%d", _score]];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player misileCollision:(CCNode *)misile {
    [misile removeFromParent];
    _score--;
    [_label setString:[NSString stringWithFormat:@"%d", _score]];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player enemyCollision:(CCNode *)enemy {
    [enemy removeFromParent];
    _score--;
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