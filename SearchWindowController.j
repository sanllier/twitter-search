// (c) 2011 by Anton Korenyushkin

@import "TweetView.j"

@implementation SearchWindowController : CPWindowController
{
}

- (id)initWithSearchString:(CPString)searchString
{
    if (self = [super init]) {
        var window = [[CPWindow alloc] initWithContentRect:CGRectMake(10, 30, 300, 400)
                                                 styleMask:CPTitledWindowMask | CPClosableWindowMask | CPResizableWindowMask];
        [window setTitle:searchString];
        [self setWindow:window];
        var request = [CPURLRequest requestWithURL:"http://search.twitter.com/search.json?q=" + encodeURIComponent(searchString)];
        [CPJSONPConnection sendRequest:request callback:"callback" delegate:self];
    }
    return self;
}

- (void)connection:(CPJSONPConnection)connection didReceiveData:(Object)data
{
    var contentView = [[self window] contentView];

    if (data.results.length) {
        var bounds = [contentView bounds],
            collectionView = [[CPCollectionView alloc] initWithFrame:bounds];
        [collectionView setAutoresizingMask:CPViewWidthSizable];
        [collectionView setMaxNumberOfColumns:1];
        [collectionView setMinItemSize:CGSizeMake(200, 100)];
        [collectionView setMaxItemSize:CGSizeMake(10000, 100)];

        var itemPrototype = [[CPCollectionViewItem alloc] init];
        [itemPrototype setView:[TweetView new]];
        [collectionView setItemPrototype:itemPrototype];
        [collectionView setContent:data.results];

        var scrollView = [[CPScrollView alloc] initWithFrame:bounds];
        [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable]
        [scrollView setDocumentView:collectionView];
        [contentView addSubview:scrollView];
    } else {
        var label = [CPTextField labelWithTitle:"No tweets"],
            boundsSize = [contentView boundsSize];
        [label setCenter:CGPointMake(boundsSize.width / 2, boundsSize.height / 2)];
        [label setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
        [contentView addSubview:label];
    }
}

@end
