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
#import "EnemyPlane_2.h"
#import "EnemyPlane_3.h"
#import "Player.h"
#import "Projectile.h"
#import "Misile.h"
#import "EnemyFactory.h"
#import "Explosion1.h"
#import "Muzzle.h"
#import "Constants.h"
#import "Cloud.h"
#import "EnemyBullet.h"
#import "GameOver.h"
#import "Health.h"
#import "Sparkle.h"
#import "TrippleShot.h"
#import "RapidFire.h"

@implementation GameScene {
    Player *_player;
}

+ (GameScene *)sceneWithPlane:(NSString*) plane_name withDaytime: (int) daytime {
    return [[self alloc] initWithPlaneName: plane_name withDaytime: (int) daytime];
    
}

- (id)initWithPlaneName:(NSString*) plane_name withDaytime: (int) daytime {
    self = [super init];
    if (!self) return(nil);
    self.level=0;
    self.userInteractionEnabled = YES;
    
    CCNodeColor *background = [self fetchBackground: daytime];
    [self addChild:background];
    
    self.physicsWorld = [CCPhysicsNode node];
    _physicsWorld.gravity = ccp(0,0);
    _physicsWorld.debugDraw = NO;
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
    _score_label.color = [CCColor whiteColor];
    [self addChild:_score_label];
    
    _fuselage_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health] fontName:@"Courier New" fontSize:15.0f];
    _fuselage_label.positionType = CCPositionTypeNormalized;
    _fuselage_label.position = ccp(0.15f, 0.85f);
    _fuselage_label.color = [CCColor whiteColor];
    [self addChild:_fuselage_label];
    
    _level_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Level: %d", self.level] fontName:@"Courier New" fontSize:15.0f];
    _level_label.positionType = CCPositionTypeNormalized;
    _level_label.position = ccp(0.15f, 0.90f);
    _level_label.color = [CCColor whiteColor];
    [self addChild:_level_label];


    [[OALSimpleAudio sharedInstance] playBg:@"game-music.mp3" loop:YES];

	return self;
}

- (CCNodeColor*) fetchBackground: (int) daytime {
    switch (daytime) {
        case DAY:
            return [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.75f blue:1.0f alpha:1.0f]];
            break;
        case SUNSET:
            return [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.85f green:0.35f blue:0.0f alpha:1.0f]];
            break;
        case NIGHT:
            return [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f]];
            break;
        default:
            return nil;
            break;
    }
}

- (void)addEnemy:(CCTime)dt {
    [self addPlane:dt];
}

- (void)addEnemy2:(CCTime)dt {
    [self addPlane2:dt];
}

- (void)addEnemy3:(CCTime)dt {
    [self addPlane3:dt];
}

- (void)addCloud:(CCTime)dt {
    CCSprite *cloud = [Cloud initCloud];

    int minY = cloud.contentSize.height / 4;
    int maxY = self.contentSize.height - cloud.contentSize.height / 2;
    int rangeY = maxY;
    int randomY = (arc4random() % rangeY) + minY;
    cloud.position = ccp(self.contentSize.width, randomY);
    CCAction *action = [CCActionMoveTo actionWithDuration:5.0f position:ccp(-cloud.contentSize.width, randomY)];
    [cloud runAction:action];
    [self addChild: cloud];
}

- (void)addPlane:(CCTime)dt {
    EnemyPlane_1 *enemy_plane1 = [[EnemyPlane_1 alloc] initWithPhysicsWorld:_physicsWorld];
    int minY = enemy_plane1.contentSize.height / 2;
    int maxY = self.contentSize.height - enemy_plane1.contentSize.height / 2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    enemy_plane1.position = ccp(self.contentSize.width, randomY);
    [_physicsWorld addChild:enemy_plane1];
}

- (void)addPlane2:(CCTime)dt {
    if(self.level>=1){
    EnemyPlane_2 *enemy_plane2 = [[EnemyPlane_2 alloc] initWithPhysicsWorld:_physicsWorld];
    int minY = enemy_plane2.contentSize.height / 2;
    int maxY = self.contentSize.height - enemy_plane2.contentSize.height / 2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    enemy_plane2.position = ccp(self.contentSize.width, randomY);
    [_physicsWorld addChild:enemy_plane2];
    }
}

- (void)addPlane3:(CCTime)dt {
    if(self.level>=2){
        EnemyPlane_3 *enemy_plane3 = [[EnemyPlane_3 alloc] initWithPhysicsWorld:_physicsWorld];
        int minY = enemy_plane3.contentSize.height / 2;
        int maxY = self.contentSize.height - enemy_plane3.contentSize.height / 2;
        int rangeY = maxY - minY;
        int randomY = (arc4random() % rangeY) + minY;
        enemy_plane3.position = ccp(self.contentSize.width, randomY);
        [_physicsWorld addChild:enemy_plane3];
    }
}

- (void)dealloc {
}

- (void)onEnter {
    [super onEnter];
    [_player schedule:@selector(shoot:) interval:DEFAULT_SHOOTING_RATE];
    [self schedule:@selector(addEnemy:) interval:1.5-self.level*0.2];
    [self schedule:@selector(addEnemy2:) interval:2.5-self.level*0.2];
    [self schedule:@selector(addEnemy3:) interval:3.5-self.level*0.2];
    [self schedule:@selector(addCloud:) interval:1.5];
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
    Explosion1* explosion_1 = [[Explosion1 alloc] initWithPosition: position withScale: scale withVelocityX:0];
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

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair enemyCollision:(EnemyPlane_1 *)enemy projectileCollision:(Projectile *)projectile {
    [projectile removeFromParent];
    BOOL enemy_died = [enemy takeDamage: projectile.damage];
    if (enemy_died) {
        _score += enemy.score;
    } else {
        _score += ENEMY_PLANE_IMPACT_SCORE;
    }
    _level = _score / 3000;
    [_score_label setString:[NSString stringWithFormat:@"Score: %d", _score]];
    if(_level <= 9){
        [_level_label setString:[NSString stringWithFormat:@"Level: %d", _level]];
    }else{
        [_level_label setString:[NSString stringWithFormat:@"NIGHTMARE"]];
    }
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player misileCollision:(Misile *)misile {
    [self createExplosionWithPosition: misile.position withScale: 0.5f];
    [misile removeFromParent];
    [_player takeDamage: misile.damage];
    [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
    [self checkIfPLayerLost];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player enemyBulletCollision:(EnemyBullet *)bullet {
    [bullet removeFromParent];
    [_player takeDamage: bullet.damage];
    [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
    [self checkIfPLayerLost];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player enemyCollision:(CCNode *)enemy {
    [self createExplosionWithPosition: enemy.position withScale: 1.0f];
    [enemy removeFromParent];
    [_player takeDamage: PLANE_COLLISION_DAMAGE];
    [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
    [self checkIfPLayerLost];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player healthCollision:(Health *)health {
    [health removeFromParent];
    [_player recoverHealth: health.health];
    [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player trippleShotCollision:(TrippleShot *)trippleShot {
    [trippleShot removeFromParent];
    [_player trippleShot];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player rapidFireCollision:(RapidFire *)rapidFire {
    [rapidFire removeFromParent];
    [_player rapidFire];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player explosionCollision:(Explosion1 *)explosion {
    [_player takeDamage: explosion.damage];
    [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
    [self checkIfPLayerLost];
    return YES;
}

- (void) checkIfPLayerLost {
    if (_player.health <= 0) {
        [[CCDirector sharedDirector] replaceScene:[GameOver sceneWithFinalScore:_score]
                                   withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
    }
}

- (void)onBackClicked:(id)sender {
    [self goBackToMenu:sender];
}

- (void)goBackToMenu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:0.5f]];
}

@end