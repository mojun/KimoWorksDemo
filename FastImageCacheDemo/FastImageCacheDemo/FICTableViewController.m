//
//  FICTableViewController.m
//  FastImageCacheDemo
//
//  Created by mo jun on 11/14/15.
//  Copyright © 2015 kimoworks. All rights reserved.
//

#import "FICTableViewController.h"
#import "PZGridPhoto.h"
#import "FICTableViewCell.h"
#import "FICImageHelper.h"

@interface FICTableViewController (){
    NSMutableArray *_photos;
}

@end

@implementation FICTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[FICImageHelper sharedHelper] setup];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSArray *imageIDs = @[
                      @"10206",
                      @"10087",
                      @"10238",
                      @"10063",
                      @"10323",
                      @"10337",
                      @"10347",
                      @"10352",
                      @"10354",
                      @"10355",
                      @"10363",
                      @"10383",
                      @"10442",
                      @"10463",
                      @"10475",
                      @"10484",
                      @"10500",
                      @"10550",
                      @"10559",
                      @"10589",
                      @"10630",
                      @"10650",
                      @"10672",
                      @"10757",
                      @"10758",
                      @"10769",
                      @"10789",
                      @"10790",
                      @"10840",
                      @"1089",
                      @"1092",
                      @"10937",
                      @"11117",
                      @"11121",
                      @"1114",
                      @"11187",
                      @"11220",
                      @"11283",
                      @"11285",
                      @"1138",
                      @"11409",
                      @"11414",
                      @"11543",
                      @"11544",
                      @"11623",
                      @"11628",
                      @"11717",
                      @"11749",
                      @"11787"
                      ];
    NSString *urlPath = @"http://7xje8e.com1.z0.glb.clouddn.com/food_thumb/%@.jpg";
    
    NSMutableArray *tmpPhotos = [NSMutableArray arrayWithCapacity:imageIDs.count];
    for (NSString *imageID in imageIDs) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:urlPath, imageID]];
        PZGridPhoto *photo = [[PZGridPhoto alloc]initWithSourceImageURL:url];
        [tmpPhotos addObject:photo];
    }
    
    while ([tmpPhotos count] < 5000) {
        [tmpPhotos addObjectsFromArray:tmpPhotos];
    }
    _photos = tmpPhotos;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _photos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FICTableViewCell *cell = (FICTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    
    // Configure the cell...
    PZGridPhoto *photo = [_photos objectAtIndex:indexPath.row];
    cell.photo = photo;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
