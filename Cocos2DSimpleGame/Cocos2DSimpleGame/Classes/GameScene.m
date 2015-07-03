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
#import "Health.h"
#import "Sparkle.h"
#import "TrippleShot.h"
#import "RapidFire.h"
#import "RocketPowerup.h"
#import "PlayerRocket.h"
#import "ShieldPowerUp.h"
#import "Boss.h"
#import "ScoreLabel.h"

@implementation GameScene {
    Player *_player;
    BOOL boss_fight;
}

+ (GameScene *)sceneWithPlane:(NSString*) plane_name withDaytime: (int) daytime withDifficulty: (int)difficulty {
    return [[self alloc] initWithPlaneName: plane_name withDaytime: (int) daytime withDifficulty:(int) difficulty];
    
}

- (id)initWithPlaneName:(NSString*) plane_name withDaytime: (int) daytime withDifficulty:(int) difficulty{
    self = [super init];
    if (!self) return(nil);
    self.level=0;
    self.userInteractionEnabled = YES;
    self.difficulty=difficulty;
    CCNodeColor *background = [self fetchBackground: daytime];
    [self addChild:background z:-50];
    
    self.physicsWorld = [CCPhysicsNode node];
    _physicsWorld.gravity = ccp(0,0);
    _physicsWorld.debugDraw = NO;
    _physicsWorld.collisionDelegate = self;
    [self addChild:_physicsWorld];
    
    _player = [[Player alloc] initWithPlaneName: plane_name withGameScene: self];
    _player.position  = ccp(self.contentSize.width/8, self.contentSize.height/2);
    [_physicsWorld addChild:_player z:1];
    
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Courier New" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f);
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    _score_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score: %d", _score] fontName:@"Courier New" fontSize:15.0f];
    _score_label.positionType = CCPositionTypeNormalized;
    _score_label.position = ccp(0.15f, 0.95f);
    _score_label.color = [CCColor whiteColor];
    [self addChild:_score_label];
    
    _fuselage_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health] fontName:@"Courier New" fontSize:15.0f];
    _fuselage_label.positionType = CCPositionTypeNormalized;
    _fuselage_label.position = ccp(0.40f, 0.95f);
    _fuselage_label.color = [CCColor whiteColor];
    [self addChild:_fuselage_label];
    
    _level_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Level: %d", self.level] fontName:@"Courier New" fontSize:15.0f];
    _level_label.positionType = CCPositionTypeNormalized;
    _level_label.position = ccp(0.60f, 0.95f);
    _level_label.color = [CCColor whiteColor];
    [self addChild:_level_label];
    
    _credits_label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Credits: %d", _player.credits] fontName:@"Courier New" fontSize:15.0f];
    _credits_label.positionType = CCPositionTypeNormalized;
    _credits_label.position = ccp(0.15f, 0.90f);
    _credits_label.color = [CCColor whiteColor];
    [self addChild:_credits_label];


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
    int rand = (arc4random()%100)-50;
    [self addChild: cloud z:rand];
}

- (void)addPlane:(CCTime)dt {
    EnemyPlane_1 *enemy_plane1 = [[EnemyPlane_1 alloc] initWithPhysicsWorld:_physicsWorld withDifficulty:_difficulty];
    int minY = enemy_plane1.contentSize.height / 2;
    int maxY = self.contentSize.height - enemy_plane1.contentSize.height / 2;
    int rangeY = maxY - minY;
    int randomY = (arc4random() % rangeY) + minY;
    enemy_plane1.position = ccp(self.contentSize.width, randomY);
    [_physicsWorld addChild:enemy_plane1];
}

- (void)addPlane2:(CCTime)dt {
    if(self.level >= 1) {
        EnemyPlane_2 *enemy_plane2 = [[EnemyPlane_2 alloc] initWithPhysicsWorld:_physicsWorld withDifficulty:_difficulty];
        int minY = enemy_plane2.contentSize.height / 2;
        int maxY = self.contentSize.height - enemy_plane2.contentSize.height / 2;
        int rangeY = maxY - minY;
        int randomY = (arc4random() % rangeY) + minY;
        enemy_plane2.position = ccp(self.contentSize.width, randomY);
        [_physicsWorld addChild:enemy_plane2];
    }
}

- (void)addPlane3:(CCTime)dt {
    if(self.level >= 2){
        EnemyPlane_3 *enemy_plane3 = [[EnemyPlane_3 alloc] initWithPhysicsWorld:_physicsWorld withDifficulty:_difficulty];
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
    [self schedule:@selector(addEnemy:) interval:MAX(MIN_SPAWN_INTERVAL, 1.5-self.level*0.2)];
    [self schedule:@selector(addEnemy2:) interval:MAX(MIN_SPAWN_INTERVAL, 2.5-self.level*0.2)];
    [self schedule:@selector(addEnemy3:) interval:MAX(MIN_SPAWN_INTERVAL, 3.5-self.level*0.2)];
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

- (void) checkLevels {
    _level = _score / SCORE_PER_LEVEL;
    [_score_label setString:[NSString stringWithFormat:@"Score: %d", _score]];
    if (_level < MAX_LEVELS) {
        [_level_label setString:[NSString stringWithFormat:@"Level: %d", _level]];
    } else {
        if (!boss_fight) {
            boss_fight = true;
            [_level_label setString:[NSString stringWithFormat:@"BOSS FIGHT"]];
            [self unschedule:@selector(addEnemy:)];
            [self unschedule:@selector(addEnemy2:)];
            [self unschedule:@selector(addEnemy3:)];
            [[OALSimpleAudio sharedInstance] playBg:@"boss.mp3"];
            [_physicsWorld addChild:[[Boss alloc] initWithGameScene:self withDifficulty:self.difficulty withPlayer:_player]];
        }
    }
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair enemyCollision:(Enemy *)enemy projectileCollision:(Projectile *)projectile {
    [projectile removeFromParent];
    if ([enemy takeDamage: projectile.damage]) { // Asks if enemy died
        [ScoreLabel label:self position:enemy.position value:enemy.score];
        _score += enemy.score;
    } else {
        [ScoreLabel label:self position:projectile.position value:ENEMY_PLANE_IMPACT_SCORE];
        _score += ENEMY_PLANE_IMPACT_SCORE;
    }
    [self checkLevels];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player missileCollision:(Misile *)misile {
    if (!_player.player_dead) {
        [self createExplosionWithPosition: misile.position withScale: 0.5f];
        [misile removeFromParent];
        [_player takeDamage: misile.damage];
        [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player enemyBulletCollision:(EnemyBullet *)bullet {
    if (!_player.player_dead) {
        [bullet removeFromParent];
        [_player takeDamage: bullet.damage];
        [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player enemyCollision:(CCNode *)enemy {
    if (!_player.player_dead) {
        [self createExplosionWithPosition: enemy.position withScale: 1.0f];
        [enemy removeFromParent];
        [_player takeDamage: PLANE_COLLISION_DAMAGE];
        [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player healthCollision:(Health *)health {
    if (!_player.player_dead) {
        [health removeFromParent];
        [_player recoverHealth: health.health];
        [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player trippleShotCollision:(TrippleShot *)trippleShot {
    if (!_player.player_dead) {
        [trippleShot removeFromParent];
        [_player trippleShot];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player rocketPowerupCollision:(RocketPowerup *)rocketPowerup {
    if (!_player.player_dead) {
        [rocketPowerup removeFromParent];
        [_player rocketPowerup];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player shieldPowerupCollision:(ShieldPowerUp *)shieldPowerUp {
    if (!_player.player_dead) {
        [shieldPowerUp removeFromParent];
        [_player shieldPowerUp];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair enemyCollision:(Enemy *)enemy playerRocketCollision:(PlayerRocket *)player_rocket {
    [self createExplosionWithPosition: player_rocket.position withScale: 0.5f];
    [player_rocket removeFromParent];
    BOOL enemy_died = [enemy takeDamage: player_rocket.damage];
    if (enemy_died) {
        [ScoreLabel label:self position:enemy.position value:enemy.score];
        _score += enemy.score;
    } else {
        [ScoreLabel label:self position:player_rocket.position value:ENEMY_PLANE_IMPACT_SCORE];
        _score += ENEMY_PLANE_IMPACT_SCORE;
    }
    _level = _score / SCORE_PER_LEVEL;
    [self checkLevels];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player rapidFireCollision:(RapidFire *)rapidFire {
    if (!_player.player_dead) {
        [rapidFire removeFromParent];
        [_player rapidFire];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair playerCollision:(CCNode *)player explosionCollision:(Explosion1 *)explosion {
    if (!_player.player_dead) {
        [_player takeDamage: explosion.damage];
        [_fuselage_label setString:[NSString stringWithFormat:@"Fuselage: %d%%", _player.health]];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair bossCollision:(Boss *)boss projectileCollision:(Projectile *)projectile {
    if (boss.is_alive) {
        [projectile removeFromParent];
        if ([boss takeDamage: projectile.damage]) { // Asks if Boss died
            [ScoreLabel label:self position:boss.position value:boss.score];
            _score += boss.score;
        } else {
            [ScoreLabel label:self position:projectile.position value:ENEMY_PLANE_IMPACT_SCORE];
            _score += ENEMY_PLANE_IMPACT_SCORE;
        }
        [self checkLevels];
        return YES;
    }
    return NO;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair bossCollision:(Boss *)boss playerRocketCollision:(PlayerRocket *)player_rocket {
    if (boss.is_alive) {
        [self createExplosionWithPosition: player_rocket.position withScale: 0.5f];
        [player_rocket removeFromParent];
        if ([boss takeDamage: player_rocket.damage]) { // Asks if Boss died
            [ScoreLabel label:self position:boss.position value:boss.score];
            _score += boss.score;
        } else {
            [ScoreLabel label:self position:player_rocket.position value:ENEMY_PLANE_IMPACT_SCORE];
            _score += ENEMY_PLANE_IMPACT_SCORE;
        }
        [self checkLevels];
        return YES;
    }
    return NO;
}

- (void)onBackClicked:(id)sender {
    [self goBackToMenu:sender];
}

- (void)goBackToMenu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

@end