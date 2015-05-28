//
//  GameParticles.m
//  collector
//
//  Created by Kain Osterholt on 3/12/11.
//  Copyright 2011 C-Stick Run. All rights reserved.
//

#import "GameParticles.h"

//
// Orbit Explosion
//
@implementation OrbitExplosionParticles
-(id) init
{
	return [self initWithTotalParticles:50];
}

-(id) initWithTotalParticles:(int)p
{
	if( (self=[super initWithTotalParticles:p]) ) {
        
		// duration
		duration = 0.1f;
		
		self.emitterMode = kCCParticleModeGravity;
        
		// Gravity Mode: gravity
		self.gravity = ccp(0,0);
		
		// Gravity Mode: speed of particles
		self.speed = 30;
		self.speedVar = 10;
		
		// Gravity Mode: radial
		self.radialAccel = 0;
		self.radialAccelVar = 0;
		
		// Gravity Mode: tagential
		self.tangentialAccel = 0;
		self.tangentialAccelVar = 0;
		
		// angle
		angle = 90;
		angleVar = 360;
        
		posVar = CGPointZero;
		
		// life of particles
		life = 0.6f;
		lifeVar = 0.2;
		
		// size, in pixels
		startSize = 12.0f;
		startSizeVar = 8.0f;
		endSize = kCCParticleStartSizeEqualToEndSize;
        
		// emits per second
		emissionRate = totalParticles/duration;
		
		// color of particles
		startColor.r = 0.5f;
		startColor.g = 0.5f;
		startColor.b = 0.8f;
		startColor.a = 1.0f;
		startColorVar.r = 0.1f;
		startColorVar.g = 0.1f;
		startColorVar.b = 0.1f;
		startColorVar.a = 0.0f;
		endColor.r = 0.1f;
		endColor.g = 0.1f;
		endColor.b = 0.8f;
		endColor.a = 0.0f;
		endColorVar.r = 0.2f;
		endColorVar.g = 0.2f;
		endColorVar.b = 0.2f;
		endColorVar.a = 0.0f;
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
        
		// additive
		self.blendAdditive = NO;
	}
	
	return self;
}
@end

//
// Player Explosion
//
@implementation PlayerExplosionParticles
-(id) init
{
	return [self initWithTotalParticles:200];
}

-(id) initWithTotalParticles:(int)p
{
	if( (self=[super initWithTotalParticles:p]) ) {
        
		// duration
		duration = 0.1f;
		
		self.emitterMode = kCCParticleModeGravity;
        
		// Gravity Mode: gravity
		self.gravity = ccp(0,0);
		
		// Gravity Mode: speed of particles
		self.speed = 100;
		self.speedVar = 30;
		
		// Gravity Mode: radial
		self.radialAccel = 0;
		self.radialAccelVar = 0;
		
		// Gravity Mode: tagential
		self.tangentialAccel = 0;
		self.tangentialAccelVar = 0;
		
		// angle
		angle = 90;
		angleVar = 360;
        
		posVar = CGPointZero;
		
		// life of particles
		life = 0.5f;
		lifeVar = 0.2;
		
		// size, in pixels
		startSize = 12.0f;
		startSizeVar = 8.0f;
		endSize = 50;
        
		// emits per second
		emissionRate = totalParticles/duration;
		
		// color of particles
		startColor.r = 0.9f;
		startColor.g = 0.2f;
		startColor.b = 0.1f;
		startColor.a = 1.0f;
		startColorVar.r = 0.1f;
		startColorVar.g = 0.1f;
		startColorVar.b = 0.1f;
		startColorVar.a = 0.0f;
		endColor.r = 0.9f;
		endColor.g = 0.7f;
		endColor.b = 0.2f;
		endColor.a = 0.0f;
		endColorVar.r = 0.5f;
		endColorVar.g = 0.2f;
		endColorVar.b = 0.2f;
		endColorVar.a = 0.0f;
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
        
		// additive
		self.blendAdditive = YES;
	}
	
	return self;
}
@end

//
// Player Trail
//
@implementation PlayerTrailParticles
-(id) init
{
	return [self initWithTotalParticles:125];
}

-(id) initWithTotalParticles:(int) p
{
	if( (self=[super initWithTotalParticles:p]) ) {
        
		// duration
		duration = kCCParticleDurationInfinity;
        
		// Gravity Mode
		self.emitterMode = kCCParticleModeGravity;
        
		// Gravity Mode: gravity
		self.gravity = ccp(0,0);
		
		// Gravity Mode: radial acceleration
		self.radialAccel = 0;
		self.radialAccelVar = 0;
		
		// Gravity Mode: speed of particles
		self.speed = 0;
		self.speedVar = 0;		
		
		// starting angle
		angle = 90;
		angleVar = 10;
		
		posVar = CGPointZero;
		
		// life of particles
		life = 0.3;
		lifeVar = 0.0f;
        
		// size, in pixels
		startSize = 26.0f;
		startSizeVar = 0.0f;
		endSize = 0.0;
        
		// emits per frame
		emissionRate = totalParticles/life;
		
		// color of particles
        startColor.r = 0.1f;
		startColor.g = 0.05f;
		startColor.b = 0.9f;
		startColor.a = 1.0f;
		startColorVar.r = 0.0f;
		startColorVar.g = 0.0f;
		startColorVar.b = 0.0f;
		startColorVar.a = 0.0f;
        endColor.r = 0.8f;
		endColor.g = 0.2f;
		endColor.b = 0.05f;
		endColor.a = 0.5f;
        endColorVar.r = 0.0f;
		endColorVar.g = 0.0f;
		endColorVar.b = 0.0f;
		endColorVar.a = 0.0f;
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
		
		// additive
		self.blendAdditive = YES;
	}
    
	return self;
}
@end

//
// Player Trail
//
@implementation OrbitTrailParticles
-(id) init
{
	return [self initWithTotalParticles:20];
}

-(id) initWithTotalParticles:(int) p
{
	if( (self=[super initWithTotalParticles:p]) ) {
        
		// duration
		duration = kCCParticleDurationInfinity;
        
		// Gravity Mode
		self.emitterMode = kCCParticleModeGravity;
        
		// Gravity Mode: gravity
		self.gravity = ccp(0,0);
		
		// Gravity Mode: radial acceleration
		self.radialAccel = 0;
		self.radialAccelVar = 0;
		
		// Gravity Mode: speed of particles
		self.speed = 0;
		self.speedVar = 0;		
		
		// starting angle
		angle = 90;
		angleVar = 0;
		
		posVar = CGPointZero;
		
		// life of particles
		life = 0.2;
		lifeVar = 0.0f;
        
		// size, in pixels
		startSize = 10.0f;
		startSizeVar = 1.0f;
		endSize = 1.0;
        
		// emits per frame
		emissionRate = totalParticles/life;
		
		// color of particles
		startColor.r = 0.2f;
		startColor.g = 0.2f;
		startColor.b = 0.6f;
		startColor.a = 1.0f;
		startColorVar.r = 0.0f;
		startColorVar.g = 0.0f;
		startColorVar.b = 0.0f;
		startColorVar.a = 0.0f;
		endColor.r = 0.0f;
		endColor.g = 0.0f;
		endColor.b = 0.2f;
		endColor.a = 0.0f;
		endColorVar.r = 0.0f;
		endColorVar.g = 0.0f;
		endColorVar.b = 0.0f;
		endColorVar.a = 0.0f;
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
		
		// additive
		self.blendAdditive = NO;
	}
    
	return self;
}
@end


//
// Player Trail
//
@implementation AsteroidExplodeParticles
-(id) init
{
	return [self initWithTotalParticles:50];
}

-(id) initWithTotalParticles:(int) p
{
	if( (self=[super initWithTotalParticles:p]) ) {
        
		// duration
		duration = 0.1f;
		
		self.emitterMode = kCCParticleModeGravity;
        
		// Gravity Mode: gravity
		self.gravity = ccp(0,0);
		
		// Gravity Mode: speed of particles
		self.speed = 20;
		self.speedVar = 30;
		
		// Gravity Mode: radial
		self.radialAccel = 0;
		self.radialAccelVar = 0;
		
		// Gravity Mode: tagential
		self.tangentialAccel = 0;
		self.tangentialAccelVar = 0;
		
		// angle
		angle = 90;
		angleVar = 360;
        
		posVar = CGPointZero;
		
		// life of particles
		life = 0.2f;
		lifeVar = 1;
		
		// size, in pixels
		startSize = 16.0f;
		startSizeVar = 4.0f;
		endSize = 40;
        
		// emits per second
		emissionRate = totalParticles/duration;
		
		// color of particles
		startColor.r = 0.2f;
		startColor.g = 0.2f;
		startColor.b = 0.2f;
		startColor.a = 1.0f;
		startColorVar.r = 0.01f;
		startColorVar.g = 0.01f;
		startColorVar.b = 0.01f;
		startColorVar.a = 0.0f;
		endColor.r = 0.3f;
		endColor.g = 0.2f;
		endColor.b = 0.1f;
		endColor.a = 0.0f;
		endColorVar.r = 0.1f;
		endColorVar.g = 0.0f;
		endColorVar.b = 0.0f;
		endColorVar.a = 0.0f;
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
        
		// additive
		self.blendAdditive = NO;
	}
    
	return self;
}
@end


//
// Player Explosion
//
@implementation FieroParticles
-(id) init
{
	return [self initWithTotalParticles:1000];
}

-(id) initWithTotalParticles:(int)p
{
	if( (self=[super initWithTotalParticles:p]) ) {
        
		// duration
		duration = 0.3f;
		
		self.emitterMode = kCCParticleModeGravity;
        
		// Gravity Mode: gravity
		self.gravity = ccp(0,0);
		
		// Gravity Mode: speed of particles
		self.speed = 300;
		self.speedVar = 30;
		
		// Gravity Mode: radial
		self.radialAccel = 0;
		self.radialAccelVar = 0;
		
		// Gravity Mode: tagential
		self.tangentialAccel = 0;
		self.tangentialAccelVar = 0;
		
		// angle
		angle = 90;
		angleVar = 360;
        
		posVar = CGPointZero;
		
		// life of particles
		life = 1.0f;
		lifeVar = 0.5;
		
		// size, in pixels
		startSize = 18.0f;
		startSizeVar = 6.0f;
		endSize = 26;
        
		// emits per second
		emissionRate = totalParticles/duration;
		
		// color of particles
		startColor.r = 0.9f;
		startColor.g = 0.2f;
		startColor.b = 0.1f;
		startColor.a = 1.0f;
		startColorVar.r = 0.2f;
		startColorVar.g = 0.1f;
		startColorVar.b = 0.1f;
		startColorVar.a = 0.0f;
		endColor.r = 0.9f;
		endColor.g = 0.3f;
		endColor.b = 0.2f;
		endColor.a = 0.0f;
		endColorVar.r = 0.2f;
		endColorVar.g = 0.2f;
		endColorVar.b = 0.2f;
		endColorVar.a = 0.0f;
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
        
		// additive
		self.blendAdditive = YES;
	}
	
	return self;
}
@end


@implementation OrbitPickupParticles
-(id) init
{
	return [self initWithTotalParticles:125];
}

-(id) initWithTotalParticles:(int) p
{
	if( (self=[super initWithTotalParticles:p]) ) {
        
		// duration
		duration = kCCParticleDurationInfinity;
        
		// Gravity Mode
		self.emitterMode = kCCParticleModeGravity;
        
		// Gravity Mode: gravity
		self.gravity = ccp(0,0);
		
		// Gravity Mode: radial acceleration
		self.radialAccel = 0;
		self.radialAccelVar = 0;
		
		// Gravity Mode: speed of particles
		self.speed = 30;
		self.speedVar = 10;		
		
		// starting angle
		angle = 90;
		angleVar = 360;
		
		posVar = CGPointZero;
		
		// life of particles
		life = 0.4;
		lifeVar = 0.0f;
        
		// size, in pixels
		startSize = 10.0f;
		startSizeVar = 0.0f;
		endSize = 4.0;
        
		// emits per frame
		emissionRate = totalParticles/life;
		
		// color of particles
        startColor.r = 0.1f;
		startColor.g = 0.05f;
		startColor.b = 0.9f;
		startColor.a = 1.0f;
		startColorVar.r = 0.0f;
		startColorVar.g = 0.0f;
		startColorVar.b = 0.0f;
		startColorVar.a = 0.0f;
        endColor.r = 0.0f;
		endColor.g = 0.1f;
		endColor.b = 0.95f;
		endColor.a = 0.5f;
        endColorVar.r = 0.0f;
		endColorVar.g = 0.0f;
		endColorVar.b = 0.0f;
		endColorVar.a = 0.0f;
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
		
		// additive
		self.blendAdditive = YES;
	}
    
	return self;
}
@end

@implementation FieroPickupParticles
-(id) init
{
	return [self initWithTotalParticles:125];
}

-(id) initWithTotalParticles:(int) p
{
	if( (self=[super initWithTotalParticles:p]) ) {
        
		// duration
		duration = kCCParticleDurationInfinity;
        
		// Gravity Mode
		self.emitterMode = kCCParticleModeGravity;
        
		// Gravity Mode: gravity
		self.gravity = ccp(0,0);
		
		// Gravity Mode: radial acceleration
		self.radialAccel = 0;
		self.radialAccelVar = 0;
		
		// Gravity Mode: speed of particles
		self.speed = 30;
		self.speedVar = 10;		
		
		// starting angle
		angle = 90;
		angleVar = 360;
		
		posVar = CGPointZero;
		
		// life of particles
		life = 0.4;
		lifeVar = 0.0f;
        
		// size, in pixels
		startSize = 10.0f;
		startSizeVar = 0.0f;
		endSize = 4.0;
        
		// emits per frame
		emissionRate = totalParticles/life;
		
		// color of particles
        startColor.r = 0.8f;
		startColor.g = 0.25f;
		startColor.b = 0.0f;
		startColor.a = 1.0f;
		startColorVar.r = 0.0f;
		startColorVar.g = 0.0f;
		startColorVar.b = 0.0f;
		startColorVar.a = 0.0f;
        endColor.r = 0.9f;
		endColor.g = 0.7f;
		endColor.b = 0.0f;
		endColor.a = 0.5f;
        endColorVar.r = 0.0f;
		endColorVar.g = 0.0f;
		endColorVar.b = 0.0f;
		endColorVar.a = 0.0f;
		
		self.texture = [[CCTextureCache sharedTextureCache] addImage: @"fire.png"];
		
		// additive
		self.blendAdditive = YES;
	}
    
	return self;
}
@end





