//
//  NotePadTextView.m
//  ACE-R
//
//  Created by Adrian Russell on 21/08/2012.
//  Copyright (c) 2012 Adrian Russell. All rights reserved.
//

#import "NotePadTextView.h"

@implementation NotePadTextView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}


- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:0.6f alpha:1.0f];
    self.font            = [UIFont fontWithName:@"Noteworthy-Light" size:24];
    self.contentInset    = UIEdgeInsetsMake(0, 35, 0, -35);
    self.contentMode     = UIViewContentModeRedraw;
}


- (void)drawRect:(CGRect)rect
{
    //Get the current drawing context
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set the line color and width
    
    //Start a new Path
    CGContextBeginPath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.2f].CGColor);
    CGContextSetLineWidth(context, 1.0f);
    
    
    //Find the number of lines in our textView + add a bit more height to draw lines in the empty part of the view
    NSUInteger numberOfLines = (self.contentSize.height + self.bounds.size.height * 2) / self.font.leading;
    
    //Set the line offset from the baseline. (I'm sure there's a concrete way to calculate this.)
    CGFloat baselineOffset = 6.0f;
    
    //iterate over numberOfLines and draw each line
    for (int x = 0; x < numberOfLines; x++)
    {
        //0.5f offset lines up line with pixel boundary
        CGContextMoveToPoint(context, self.bounds.origin.x, self.font.leading*x + 0.5f + baselineOffset + self.font.descender);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.font.leading*x + 0.5f + baselineOffset + self.font.descender);
    }
    
    //Close our Path and Stroke (draw) it;
    CGContextStrokePath(context);
    
    // Draw one red vertical line of the margin
    CGContextBeginPath(context); 
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.6f].CGColor); 
    CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, self.bounds.origin.x + 30, self.bounds.origin.y);
    CGContextAddLineToPoint(context, self.bounds.origin.x + 30, self.contentSize.height + self.bounds.size.height * 2);
    CGContextStrokePath(context);

    
    // Draw the other red vertical line of the margin
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.6f].CGColor);
    CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, self.bounds.origin.x + 35, self.bounds.origin.y);
    CGContextAddLineToPoint(context, self.bounds.origin.x + 35, self.contentSize.height + self.bounds.size.height * 2);
    CGContextStrokePath(context);
}


@end
