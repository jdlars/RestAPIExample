//
//  ViewController.m
//  RestAPIExample
//
//  Created by Larson, Jordan (UMKC-Student) on 9/14/15.
//  Copyright (c) 2015 Larson, Jordan (UMKC-Student). All rights reserved.
//

#import "ViewController.h"
#import "WeatherViewController.h"
#import "AFHTTPRequestOperationManager.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *currentCity;
@property (weak, nonatomic) IBOutlet UITextField *currentState;
@property (weak, nonatomic) IBOutlet UITextView *weatherSummary;

@property (nonatomic, strong) NSDictionary *current_obs;
@property (nonatomic, strong) NSString *tempature;
@property (nonatomic, strong) NSString *clouds;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)tappedHowIsWeather:(id)sender {
    NSString *str = @"Currently, in ";
    str = [str stringByAppendingString:_currentCity.text];
    str = [str stringByAppendingString:@", "];
    str = [str stringByAppendingString:_currentState.text];
    str = [str stringByAppendingString:@", it is "];
    
    NSArray *citySpaceDelimited = [_currentCity.text componentsSeparatedByString:@" "];
    
    NSString *cityStateUrlPartial = @"";
    //Append base url
    cityStateUrlPartial = [cityStateUrlPartial stringByAppendingString:@"http://api.wunderground.com/api/937f43884a1723f4/geolookup/conditions/q/"];
    //Append state code
    cityStateUrlPartial = [cityStateUrlPartial stringByAppendingString:_currentState.text];
    cityStateUrlPartial = [cityStateUrlPartial stringByAppendingString:@"/"];
    
    
    //Append city name
    for (int i=0; i<[citySpaceDelimited count]; i++) {
        if (i > 0 && i <[citySpaceDelimited count]) {
            cityStateUrlPartial = [cityStateUrlPartial stringByAppendingString:@"_"];
        }
        cityStateUrlPartial = [cityStateUrlPartial stringByAppendingString:citySpaceDelimited[i]];
    }
    
    
    cityStateUrlPartial = [cityStateUrlPartial stringByAppendingString:@".json"];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:cityStateUrlPartial parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        _current_obs = [responseObject objectForKey:@"current_observation"];
//        _tempature = [_current_obs objectForKey:@"temp_f"];
//        _clouds =
//        
//        [_responseTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error description]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    
    
    str = [str stringByAppendingString:[NSString stringWithFormat:@"%@", _current_obs]];
    
    str = [str stringByAppendingString:@" and "];
    
    
    
    str = [str stringByAppendingString:@" degrees!"];
    _weatherSummary.text = str;
}


@end
