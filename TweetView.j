// (c) 2011 by Anton Korenyushkin

@implementation TweetView : CPView
{
    CPImageView imageView;
    CPTextField userLabel;
    CPTextField tweetLabel;
}

- (void)setRepresentedObject:(id)tweet
{
    if (!imageView) {
        imageView = [[CPImageView alloc] initWithFrame:CGRectMake(10, 5, 48, 48)];
        [self addSubview:imageView];

        userLabel = [[CPTextField alloc] initWithFrame:CGRectMake(65, 0, -60, 18)];
        [userLabel setAutoresizingMask:CPViewWidthSizable];
        [userLabel setFont:[CPFont boldSystemFontOfSize:12]];
        [self addSubview:userLabel];

        tweetLabel = [[CPTextField alloc] initWithFrame:CGRectMake(65, 18, -60, 100)];
        [tweetLabel setAutoresizingMask:CPViewWidthSizable];
        [tweetLabel setLineBreakMode:CPLineBreakByWordWrapping];
        [self addSubview:tweetLabel];
    }
    [imageView setImage:[[CPImage alloc] initWithContentsOfFile:tweet.profile_image_url size:CGSizeMake(48, 48)]];
    [userLabel setStringValue:tweet.from_user];
    [tweetLabel setStringValue:tweet.text];
}

@end
