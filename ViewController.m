//
//  ViewController.m
//  SampleVedioToGif
//
//  Created by Jincy Saramma Varughese on 20/02/17.
//  Copyright © 2017 Jincy Saramma Varughese. All rights reserved.
//

#import "ViewController.h"
#import "NSGIF.h"
#import <Photos/Photos.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSURL *url = info[UIImagePickerControllerMediaURL];
    if (url){
        
        [self.activityIndicator startAnimating];
        self.button.enabled = NO;
        
        [NSGIF optimalGIFfromURL:url loopCount:0 completion:^(NSURL *GifURL) {
        
            NSLog(@"Finished generating GIF: %@", GifURL);
            
            [self.activityIndicator stopAnimating];
            [UIView animateWithDuration:0.3 animations:^{
                self.button.alpha = 0.0f;
            }];
            [self.webView loadRequest:[NSURLRequest requestWithURL:GifURL]];

            UIAlertController *alertController;
            if(GifURL) {
                alertController = [UIAlertController alertControllerWithTitle:@"Yaay!"
                                                                      message:@"You successfully created your GIF!"
                                                               preferredStyle:UIAlertControllerStyleAlert];
            }
            else {
                alertController = [UIAlertController alertControllerWithTitle:@"Ooops!"
                                                                      message:@"Hmm... Something went wrong here!"
                                                               preferredStyle:UIAlertControllerStyleAlert];
            }
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil]; //You can use a block here to handle a press on this button
            [alertController addAction:actionOk];
            [self presentViewController:alertController animated:YES completion:nil];
            
            }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"Received memory warning. Try to tweak your GIF parameters to optimise the converting process.");
    
    // Dispose of any resources that can be recreated.
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (IBAction)buttonAction:(id)sender {
    [self.activityIndicator startAnimating];
    self.button.enabled = NO;
    
    NSURL *fileURL = [NSURL fileURLWithPath:NSTemporaryDirectory()];
    if (fileURL)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (fileExists) {
        NSLog(@"file exists");
            [self clearBundle];
            
            NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
            [NSGIF optimalGIFfromURL:videoURL loopCount:0 completion:^(NSURL *GifURL) {
                
                NSLog(@"Finished generating GIF: %@", GifURL);
                
                [self.activityIndicator stopAnimating];
                [UIView animateWithDuration:0.3 animations:^{
                    self.button.alpha = 0.0f;
                    self.webView.alpha = 1.0f;
                }];
                [self.webView loadRequest:[NSURLRequest requestWithURL:GifURL]];
            }];
            
        }
        else
        {
        NSLog(@"file not exists");
            NSURL *videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
            [NSGIF optimalGIFfromURL:videoURL loopCount:0 completion:^(NSURL *GifURL) {
                
                NSLog(@"Finished generating GIF: %@", GifURL);
                
                [self.activityIndicator stopAnimating];
                [UIView animateWithDuration:0.3 animations:^{
                    self.button.alpha = 0.0f;
                    self.webView.alpha = 1.0f;
                }];
                [self.webView loadRequest:[NSURLRequest requestWithURL:GifURL]];
            }];
        }
    }
    

}
-(void)clearBundle
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSString *fullPath = fileName;
    NSLog(@"image: %@", fileName);
    [fileManager removeItemAtPath: fullPath error:NULL];

    NSString *appFolderPath = [[NSBundle mainBundle] resourcePath];
    NSLog(@"Directory Contents:\n%@", [fileManager contentsAtPath:appFolderPath]);
    
    
}

@end
