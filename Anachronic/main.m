//
//  main.m
//  Anachronic
//
//  Created by Keyvan Fatehi on 9/10/13.
//  Copyright (c) 2013 Keyvan Fatehi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
    return macruby_main("rb_main.rb", argc, argv);
}
