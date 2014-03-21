//
//  ViewController.m
//  Genius_Test_OfficeTestUse
//
//  Created by Genius on 2014/3/21.
//  Copyright (c) 2014年 Genius. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self getJasonData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getJasonData
{
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:MOVIE_SEARCH_URL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    //NSLog(@"Get Url = %@", MOVIE_SEARCH_URL);
    
	[request setValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    m_server_data = [[NSMutableData alloc] init];
    
    m_connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark -
#pragma mark connection event

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [m_connect cancel];
    
    m_connect = nil;
    
    m_server_data = nil;
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [connection cancel];
    
    if(connection == m_connect)
    {
        m_url_ary = [[[m_server_data mutableObjectFromJSONData] objectForKey:@"movies"] copy];
        
        if([m_url_ary count] == 0) return;
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"year" ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        m_url_ary = (NSMutableArray *)[m_url_ary sortedArrayUsingDescriptors:sortDescriptors];
        
        [m_tableview reloadData];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection == m_connect) [m_server_data appendData:data];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 return 400;
 }*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_url_ary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    int row = [indexPath row];
    
    NSString *m_title = [[m_url_ary objectAtIndex:row] objectForKey:@"title"];
    
    NSString *m_year = [[m_url_ary objectAtIndex:row] objectForKey:@"year"];
    
    NSString *m_rating = [[m_url_ary objectAtIndex:row] objectForKey:@"rating"];
    
    NSString *m_image_url = [[[[m_url_ary objectAtIndex:row] objectForKey:@"poster"] objectForKey:@"urls"] objectForKey:@"original"];
    
    cell.textLabel.text = m_title;
    
    NSString *m_str = [NSString stringWithFormat:@"Year : %@     Rating : %@", m_year, m_rating];
    
    cell.detailTextLabel.text = m_str;
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:m_image_url] placeholderImage:[UIImage imageNamed:@"bkimage2.png"]];
    
    return cell;
}

@end
