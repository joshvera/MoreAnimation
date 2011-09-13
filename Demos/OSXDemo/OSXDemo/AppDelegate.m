//
//  AppDelegate.m
//  OSXDemo
//
//  Created by Justin Spahr-Summers on 2011-09-11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <MoreAnimation/MoreAnimation.h>


@interface AppDelegate () <MALayerDelegate>
@property (nonatomic, strong) MALayer *prettyLayer;
@end


@implementation AppDelegate


#pragma mark NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	self.prettyLayer = [[MALayer alloc] init];
	self.prettyLayer.delegate = self;
	self.prettyLayer.frame = self.openGLView.contentLayer.frame;
	[self.openGLView.contentLayer addSublayer:self.prettyLayer];

    NSButton *anchorButton = [NSButton new];
    [anchorButton setButtonType:NSMomentaryLightButton];
    [anchorButton setTitle:NSLocalizedString(@"DEMO_VIEW_CHANGE_ANCHOR_BUTTON_TITLE", @"Change anchor point")];
    [anchorButton setAction:@selector(changeAnchor)];
    [anchorButton setTarget:self];
    anchorButton.frame = CGRectMake(10, 10, 100, 100);
    [self.window.contentView addSubview:anchorButton];

	[self.openGLView setNeedsDisplay:YES];
}


#pragma mark MALayerDelegate

- (void)drawLayer:(MALayer *)layer inContext:(CGContextRef)context {
	NSImage *nsImage = [NSImage imageNamed:@"test"];
	CGContextDrawImage(context, layer.bounds, [nsImage CGImageForProposedRect:NULL context:NULL hints:nil]);

	CGContextSetFillColor(context, (CGFloat []) { 0.0f, 0.0f, 1.0f, 1.0f });
	CGContextFillRect(context, CGRectMake(20.0f, 20.0f, 200.0f, 200.0f));

	CGContextSetFillColor(context, (CGFloat []) { 1.0f, 0.0f, 0.0f, 1.0f });
	CGContextFillRect(context, CGRectMake(70.0f, 70.0f, 100.0f, 100.0f));
}


#pragma mark API

@synthesize window;
@synthesize openGLView;
@synthesize changeAnchorMenuItem;
@synthesize prettyLayer;

#pragma mark Actions
- (IBAction)changeAnchorPoint:(id)sender {
    CGPoint oldAnchor = self.prettyLayer.anchorPoint;
    CGPoint newAnchor = CGPointMake(
        oldAnchor.x * (1/oldAnchor.x)
        ,oldAnchor.y * (1/oldAnchor.y)
    );

    self.openGLView.contentLayer.anchorPoint = newAnchor;
    [self.openGLView setNeedsDisplay:YES];
}

@end
