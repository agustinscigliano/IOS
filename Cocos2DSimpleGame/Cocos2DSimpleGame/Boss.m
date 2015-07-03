//
//  Boss.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 2/7/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Boss.h"

@implementation Boss {
    GameScene *game_scene;
    Player *player;
    int health;
    int shooting_probability;
    int direction;
    int frame_number;
}

- (id) initWithGameScene: (GameScene*) gs withDifficulty:(int)difficulty withPlayer: (Player*) p {
    self = [super init];
    if (self) {
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: BOSS_SPRITE]];
        self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
        self.physicsBody.collisionCategories = @[BOSS_COLLISION];
        self.physicsBody.collisionType = BOSS_COLLISION;
        self.physicsBody.sensor = YES;
        health = BOSS_HEALTH;
        game_scene = gs;
        self.score = ENEMY_PLANE_3_SCORE;
        self.scale = BOSS_SCALE;
        shooting_probability = ENEMY_PLANE_SHOOTING_PROBABILITY - difficulty;
        self.position = ccp(game_scene.contentSize.width, game_scene.contentSize.height/2);
        direction = GOING_UP;
        frame_number = 1;
        _is_alive = YES;
        player = p;
    }
    return self;
}

- (void) update:(CCTime)delta
{
    if (_is_alive) {
        if (self.position.x < game_scene.contentSize.width*0.8) {
            if (direction == GOING_UP) {
                if (self.position.y > player.position.y) {
                    direction = GOING_DOWN;
                } else {
                    self.physicsBody.velocity = ccp(0, 50);
                }
            } else {
                if (self.position.y < player.position.y) {
                    direction = GOING_UP;
                } else {
                    self.physicsBody.velocity = ccp(0, -50);
                }
            }
        } else {
            self.physicsBody.velocity = ccp(ENEMY_PLANE_1_SPEED, 0);
        }
    } else {
        self.physicsBody.velocity = ccp(0, 0);
    }
}

- (BOOL) takeDamage: (int) damage {
    health -= damage;
    if (health <= 0) {
        [self playRandomExplosionSound];
        self.physicsBody.velocity = ccp(0, 0);
        _is_alive = NO;
        [self schedule:@selector(animateExplosion:) interval:0.20 repeat:0 delay:0];
    }
    int random_sound_index = (arc4random() % 2) + 1;
    NSString* random_sound_name = [NSString stringWithFormat:@"hit_%d.mp3", random_sound_index];
    [[OALSimpleAudio sharedInstance] playEffect:random_sound_name];
    [self addChild: [[Sparkle alloc] init]];
    [PowerUpFactory randomPowerUp:game_scene.physicsWorld dropProbability:BOSS_DROP_PROBABILITY position:self.position];
    return NO;
}

- (void) animateExplosion: (CCTime) dt {
    self.scale = 3.0;
    NSString *frame_path = [NSString stringWithFormat:@"%@%d.png", EXPLOSION_1_IMAGE, frame_number];
    [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: frame_path]];
    frame_number++;
    if (frame_number >= MAX_FRAMES_FOR_EXPLOSION_1) {
        [self playerWon];
    }
}

- (void) playRandomExplosionSound {
    int image_number = (arc4random() % EXPLOSION_SOUNDS_AMOUNT) + 1;
    NSString* explosion_sound_path = [NSString stringWithFormat: @"%@%d.caf", EXPLOSION_SOUND_FILE_NAME, image_number];
    [[OALSimpleAudio sharedInstance] playEffect: explosion_sound_path volume:2.0 pitch:1.0 pan:0.5 loop: NO];
}

- (void) playerWon {
    [[CCDirector sharedDirector] replaceScene:[GameOver sceneWithFinalScore:game_scene.score isGameOver:NO]];
}

@end