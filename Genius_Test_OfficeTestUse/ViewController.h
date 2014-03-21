//
//  ViewController.h
//  Genius_Test_OfficeTestUse
//
//  Created by Genius on 2014/3/21.
//  Copyright (c) 2014年 Genius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "UIImageView+WebCache.h"

#define MOVIE_SEARCH_URL @"http://api.movies.io/movies/search?q=ring"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *m_tableview;
    
    NSMutableData *m_server_data;
    NSURLConnection *m_connect;
    
    NSMutableArray *m_url_ary;
}

- (void)getJasonData;

@end
