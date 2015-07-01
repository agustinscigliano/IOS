//
//  Player.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 29/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Projectile.h"
#import "Muzzle.h"
#import "Constants.h"
#import "Sparkle.h"
#import "GameOver.h"
#import "PlayerRocket.h"
#define SPEED 200
#define POSITION_DELTA 5.0f

@implementation Player {
    GameScene* game_scene;
    NSTimeInterval tripple_shot_timeout;
    NSTimeInterval rapid_fire_timeout;
    BOOL triple_shoot_power_up;
    int frame_number;
}

- (id) initWithPlaneName: (NSString*) plane_name {
    self = [super init];
    if (self) {
        self.plane_name = plane_name;
        self = [super initWithImageNamed: self.plane_name];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionType = PLAYER_COLLISION;
        self.physicsBody.type = CCPhysicsBodyTypeStatic;
        self.fire_rate = DEFAULT_SHOOTING_RATE;
        self.bullet_speed = DEFAULT_BULLET_SPEED;
        self.scale = PLANE_SCALE;
        self.health = PLAYER_MAX_HEALTH;
        triple_shoot_power_up = NO;
        _credits = INITIAL_CREDITS;
    }
    return self;
}

- (id) initWithPlaneName: (NSString*) plane_name withGameScene: (GameScene*) gs {
    self = [self initWithPlaneName: plane_name];
    game_scene = gs;
    return self;
}

- (void) trippleShot {
    triple_shoot_power_up = YES;
    [self schedule:@selector(stopTrippleShot:) interval:1 repeat:0 delay:TRIPPLE_SHOT_DURATION];
}

- (void) stopTrippleShot:(CCTime)dt {
    triple_shoot_power_up = NO;
}

- (void) stopRapidFire:(CCTime)dt {
    [self updateFireRate:DEFAULT_SHOOTING_RATE];
}

- (void) rapidFire {
    [self updateFireRate:0.15];
    [self schedule:@selector(stopRapidFire:) interval:1 repeat:0 delay:RAPID_FIRE_DURATION];
}

- (void) update:(CCTime)delta {
    if (!_player_dead) {
        CGPoint position_difference = ccpSub(_final_position, self.position);
        if(_isTouched && sqrt(pow(position_difference.x, 2) + pow(position_difference.y, 2)) > POSITION_DELTA) {
            [self setPosition:ccp(self.position.x + _velocity.x * SPEED * delta, self.position.y + _velocity.y * SPEED * delta)];
        }
    }
}

- (void) takeDamage:(int)damage {
    int random_sound_index = (arc4random() % 2) + 1;
    NSString* random_sound_name = [NSString stringWithFormat:@"hit_%d.mp3", random_sound_index];
    [[OALSimpleAudio sharedInstance] playEffect:random_sound_name volume:0.25f pitch:1.0f pan:0.5f loop:NO];
    [self addChild: [[Sparkle alloc] init]];
    _health -= damage;
    if (_health <= 0) {
        _player_dead = YES;
        [self playRandomExplosionSound];
        [self schedule:@selector(animateExplosion:) interval:0.1 repeat:0 delay:0];
        [self schedule:@selector(checkIfPlayerLost:) interval:1 repeat:0 delay:0.1*MAX_FRAMES_FOR_EXPLOSION_1];
        [self updateFireRate:DEFAULT_SHOOTING_RATE];
        triple_shoot_power_up = NO;
        [self unschedule:@selector(shootRockets:)];
        [self unschedule:@selector(stopRockets:)];
    }
}

- (void) animateExplosion: (CCTime) dt {
    self.scale = 1.0;
    NSString *frame_path = [NSString stringWithFormat:@"%@%d.png", EXPLOSION_1_IMAGE, frame_number];
    [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: frame_path]];
    frame_number++;
}

- (void) checkIfPlayerLost:(CCTime) dt {
    [self unschedule:@selector(animateExplosion:)];
    if (_credits > 0) {
        _credits--;
        frame_number = 1;
        self.health = PLAYER_MAX_HEALTH;
        self.scale = PLANE_SCALE;
        _player_dead = NO;
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed:_plane_name]];
        [game_scene.fuselage_label setString: @"Fuselage: 100%"];
        [game_scene.credits_label setString: [NSString stringWithFormat: @"Credits: %d", _credits]];
        [self unschedule:@selector(checkIfPlayerLost:)];
    } else {
        [[CCDirector sharedDirector] replaceScene:[GameOver sceneWithFinalScore:game_scene.score]];
    }
}

- (void) playRandomExplosionSound {
    int image_number = (arc4random() % EXPLOSION_SOUNDS_AMOUNT) + 1;
    NSString* explosion_sound_path = [NSString stringWithFormat: @"%@%d.caf", EXPLOSION_SOUND_FILE_NAME, image_number];
    [[OALSimpleAudio sharedInstance] playEffect: explosion_sound_path volume:1.5 pitch:1.0 pan:0.5 loop: NO];
}

- (void) recoverHealth:(int)health {
    if (_health + health > PLAYER_MAX_HEALTH) {
        _health = PLAYER_MAX_HEALTH;
    } else {
        _health += health;
    }
}

- (void) updateFireRate: (CCTime) fire_rate {
    [self unschedule: @selector(shoot:)];
    [self schedule:@selector(shoot:) interval:fire_rate];
}

- (void)shoot:(CCTime)dt {
    if (!_player_dead) {
        CGPoint shoot_position = ccp(self.position.x + 50, self.position.y);
        if (triple_shoot_power_up) {
            [self trippleShot:dt from: shoot_position];
        } else {
            [self shootNormalBullet:dt from: shoot_position];
        }
    }
}

- (void) rocketPowerup {
    [self schedule:@selector(shootRockets:) interval:0.5];
    [self schedule:@selector(stopRockets:) interval:1 repeat:0 delay:ROCKET_POWERUP_DURATION];
}

- (void) shootRockets: (CCTime)dt {
    if (!_player_dead) {
        PlayerRocket *player_rocket = [[PlayerRocket alloc] initWithPosition:ccp(self.position.x + 50, self.position.y) screenSize:game_scene.contentSize.width];
        [game_scene.physicsWorld addChild:player_rocket];
    }
}

- (void) stopRockets: (CCTime) dt {
    [self unschedule:@selector(shootRockets:)];
}

- (void)trippleShot: (CCTime)dt from: (CGPoint)position {
    [self shootNormalBullet:dt from:position];
    [self shootDiagonal:dt from:position direction: -1];
    [self shootDiagonal:dt from:position direction: 1];
}

- (void)shootDiagonal:(CCTime)dt from:(CGPoint)position direction:(int)direction {
    Projectile *projectile = [[Projectile alloc] initWithPosition:position withSpeed: (self.bullet_speed + self.physicsBody.velocity.x) screenSize:game_scene.contentSize.width];
    projectile.rotation = -direction*5;
    projectile.physicsBody.velocity = ccp(500, direction*100);
    [game_scene.physicsWorld addChild:projectile];
}

- (void)shootNormalBullet:(CCTime)dt from:(CGPoint)position {
    Projectile *projectile = [[Projectile alloc] initWithPosition:position withSpeed: (self.bullet_speed + self.physicsBody.velocity.x) screenSize:game_scene.contentSize.width];
    Muzzle* muzzle = [[Muzzle alloc] initWithPosition: ccp(0.9, 0.5)];
    muzzle.positionType = CCPositionTypeNormalized;
    [muzzle schedule:@selector(animate:) interval:0.05];
    [game_scene.physicsWorld addChild:projectile];
    [self addChild:muzzle];
}

@end