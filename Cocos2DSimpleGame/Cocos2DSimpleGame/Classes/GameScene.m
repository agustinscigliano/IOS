//
//  GameScene.m
//  Cocos2DSimpleGame
//
//  Created by Martin Walsh on 18/01/2014.
//  Copyright Razeware LLC 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "GameScene.h"
#import "IntroScene.h"
#import "EnemyPlane_1.h"
#import "Player.h"
#import "Projectile.h"
#import "Misile.h"
#import "EnemyFactory.h"
#import "Explosion1.h"
#import "Muzzle.h"
#import "Constants.h"

@implementation GameScene {
    Player *_player;
}

+ (GameScene *)sceneWithPlane:(NSString*) plane_name {
    return [[self alloc] initWithPlaneName: plane_name];
    
}

- (id)initWithPlaneName:(NSString*) plane_name {
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.75f blue:1.0f alpha:1.0f]];
    [self addChild:background];
    
    self.physicsWorld = [CCPhysicsNode node];
    _physicsWorld.gravity = ccp(0,0);
    _physicsWorld.debugDraw = YES;
    _physicsWorld.collisionDelegate = self;
    [self addChild:_physicsWorld];
    
    _player = [[Player alloc] initWithPhysicsWorld: _physicsWorld planeName: plane_name withScreenSize: self.contentSize.width];
    _player.position  = ccp(self.contentSize.width/8, self.contentSize.height/2);
    [_physicsWorld addChild:_player];
    
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Courier New" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f);
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    _score_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %d", _player.score] fontName:@"Courier New" fontSize:15.0f];
    _score_label.positionType = CCPositionTypeNormalized;
    _score_label.position = ccp(0.15f, 0.95f);
    _score_label.color = [CCColor redColor];
    [self addChild:_score_label];
    
    _fuselage_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health] fontName:@"Courier New" fontSize:15.0f];
    _fuselage_label.positionType = CCPositionTypeNormalized;
    _fuselage_label.position = ccp(0.15f, 0.85f);
    _fuselage_label.color = [CCColor redColor];
    [self addChild:_fuselage_label];

    [[OALSimpleAudio sharedInstance] playBg:@"game-music.mp3" loop:YES];

	return self;
}

- (void)addEnemy:(CCTime)dt {
    [self addPlane:dt];
}

- (void)addPlane:(CCTime)dt {
    EnemyPlane_1 *enemy_plane1 = [EnemyFactory createEnemyPlane1:self];
    
    // 1
    int minY = enemy_plane1.contentSize.height / 2;
    int maxY = self.contentSize.height - enemy_plane1.contentSize.height / 2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    enemy_plane1.position = ccp(self.contentSize.width, randomY);
    [_physicsWorld addChild:enemy_plane1];
}

- (void)dealloc {
}

- (void)onEnter {
    [super onEnter];
    [_player schedule:@selector(shoot:) interval:DEFAULT_SHOOTING_RATE];
    [self schedule:@selector(addEnemy:) interval:1.5];
}

- (void)onExit {
    [super onExit];
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [self move: touch withEvent: event];
}

- (void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    [self move: touch withEvent: event];
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    _player.isTouched = NO;
}

- (void) createExplosionWithPosition: (CGPoint) position withScale: (float) scale {
    Explosion1* explosion_1 = [[Explosion1 alloc] initWithPosition: position withScale: scale];
    [explosion_1 schedule:@selector(animate:) interval:	0.05];
    [_physicsWorld addChild: explosion_1];
}

- (void) move:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInNode:self];
    CGPoint offset = ccpSub(touchLocation, _player.position);
    float offsetModule = sqrt(offset.x*offset.x+offset.y*offset.y);
    float offsetModuleX = offset.x/offsetModule;
    float offsetModuleY = offset.y/offsetModule;
    CGPoint versorV = ccp(offsetModuleX, offsetModuleY);
    _player.velocity = versorV;
    _player.final_position = touchLocation;
    _player.isTouched = YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair enemyCollision:(CCNode *)enemy projectileCollision:(CCNode *)projectile {
    [projectile removeFromParent];
    [self createExplosionWithPosition: enemy.position withScale: 1.0f];
    [enemy removeFromParent];
    [_score_label setString:[NSString stringWithFormat:@"Score: %d", _player.score]];
    [_player addScore:1];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player misileCollision:(Misile *)misile {
    [self createExplosionWithPosition: misile.position withScale: 0.5f];
    [misile removeFromParent];
    [_player takeDamage: misile.damage];
    [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player enemyCollision:(CCNode *)enemy {
    [self createExplosionWithPosition: enemy.position withScale: 1.0f];
    [enemy removeFromParent];
    [_player takeDamage: PLANE_COLLISION_DAMAGE];
    [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
    return YES;
}

- (void)onBackClicked:(id)sender {
    [self goBackToMenu:sender];
}

- (void)goBackToMenu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

@end