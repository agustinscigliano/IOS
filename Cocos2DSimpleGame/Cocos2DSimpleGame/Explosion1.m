//
//  Explosion1.m
//  Cocos2DSimpleGame
//
//  Created by German Romarion on 12/6/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Explosion1.h"
#import "Constants.h"

@implementation Explosion1 {
    int frame_number;
}

- (id) initWithPosition:(CGPoint)position withScale: (float) scale withVelocityX: (int) velocity_x {
    frame_number = 1;
    NSString* image_path = [NSString stringWithFormat: @"%@%d.png", EXPLOSION_1_IMAGE, frame_number];
    self = [super initWithImageNamed: image_path];
    self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:self.contentSize.width/2.0f andCenter:self.anchorPointInPoints];
    self.physicsBody.sensor = YES;
    self.physicsBody.collisionCategories = @[EXPLOSION_COLLISION];
    self.physicsBody.collisionType  = EXPLOSION_COLLISION;
    self.position = position;
    self.scale = scale;
    self.physicsBody.velocity = ccp(velocity_x, 0);
    self.damage = DEFAULT_EXPLOSION_DAMAGE;
    [self playRandomExplosionSound];
    return self;
}

- (void) animate: (CCTime) dt {
    NSString *frame_path = [NSString stringWithFormat:@"%@%d.png", EXPLOSION_1_IMAGE, frame_number];
    [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed: frame_path]];
    frame_number++;
    if (frame_number == MAX_FRAMES_FOR_EXPLOSION_1) {
        [self removeFromParent];
    }
}

- (void) playRandomExplosionSound {
    int image_number = (arc4random() % EXPLOSION_SOUNDS_AMOUNT) + 1;
    NSString* explosion_sound_path = [NSString stringWithFormat: @"%@%d.caf", EXPLOSION_SOUND_FILE_NAME, image_number];
    [[OALSimpleAudio sharedInstance] playEffect: explosion_sound_path volume:0.5 pitch:1.0 pan:0.5 loop: NO];
}

@end