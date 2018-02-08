//
//  YDExtension.m
//  TestCoreText
//
//  Created by mac on 8/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

// only for iOS
#import "YDExtension.h"

NSString* HexStrigFromColorByGrayScale(CGFloat *components, NSString *stringFormat);
NSString* HexStringFromColorByRGB(CGFloat *components, NSString *stringFormat);

UIColor* CreateColorWithHtmlName(NSString *colorName);
static UIColor* CreateColorWithRGBAName(NSString *rgbaName);
static UIColor *CreateColorWithRGBName(NSString *rgbName);
static UIColor *CreateColorWithOtherName(NSString *colorName);


static const CGFloat kGrayScaleComponentsNum = 2;
static const CGFloat kGRBComponentsNum =4;

static const NSDictionary *colorDict = nil;

static NSUInteger _integerValueFromHexString(NSString *hexString) {
    int result = 0;
    sscanf([hexString UTF8String], "%x", &result);
    return result;
}

// create color
UIColor* YD_CreateColorWithHexString(NSString *hexString) {
    
    //    hex strong for color's format like as: #6655444 or #654
    if (hexString.length != 6 && hexString.length !=3) {
        return nil;
    }
    NSUInteger digits = [hexString length]/3;
    CGFloat maxValue  = (digits == 1)? 15.f:255.f;
    
//    component base color
    //    redColor :#F00/FF0000 greenColor:#0F0/#00FF00 blueColor:#00F/0000FF
    NSUInteger redI = _integerValueFromHexString([hexString substringWithRange:NSMakeRange(0.f, digits)]);
    NSInteger greenI = _integerValueFromHexString([hexString substringWithRange:NSMakeRange(digits, digits)]);
    NSInteger blueI = _integerValueFromHexString([hexString substringWithRange:NSMakeRange(digits *2, digits)]);
    CGFloat redValue = redI /maxValue;
    CGFloat greenValue = greenI /maxValue;
    CGFloat blueValue = blueI /maxValue;
    
    return [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.f];
}

UIColor* CreateColorWithHtmlName(NSString *colorName) {
    if ([colorName hasPrefix:@"#"]) {
        return YD_CreateColorWithHexString([colorName substringFromIndex:1]);
    }
    
    if ([colorName hasPrefix:@"rgba"]) {
        return CreateColorWithRGBAName(colorName);
    }
    
    if ([colorName hasPrefix:@"rbg"]) {
        return CreateColorWithRGBName(colorName);
    }
    return CreateColorWithOtherName(colorName);
}

UIColor *CreateColorWithOtherName(NSString *colorName) {
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        colorDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"F0F8FF", @"aliceblue",
                       @"FAEBD7", @"antiquewhite",
                       @"00FFFF", @"aqua",
                       @"7FFFD4", @"aquamarine",
                       @"F0FFFF", @"azure",
                       @"F5F5DC", @"beige",
                       @"FFE4C4", @"bisque",
                       @"000000", @"black",
                       @"FFEBCD", @"blanchedalmond",
                       @"0000FF", @"blue",
                       @"8A2BE2", @"blueviolet",
                       @"A52A2A", @"brown",
                       @"DEB887", @"burlywood",
                       @"5F9EA0", @"cadetblue",
                       @"7FFF00", @"chartreuse",
                       @"D2691E", @"chocolate",
                       @"FF7F50", @"coral",
                       @"6495ED", @"cornflowerblue",
                       @"FFF8DC", @"cornsilk",
                       @"DC143C", @"crimson",
                       @"00FFFF", @"cyan",
                       @"00008B", @"darkblue",
                       @"008B8B", @"darkcyan",
                       @"B8860B", @"darkgoldenrod",
                       @"A9A9A9", @"darkgray",
                       @"A9A9A9", @"darkgrey",
                       @"006400", @"darkgreen",
                       @"BDB76B", @"darkkhaki",
                       @"8B008B", @"darkmagenta",
                       @"556B2F", @"darkolivegreen",
                       @"FF8C00", @"darkorange",
                       @"9932CC", @"darkorchid",
                       @"8B0000", @"darkred",
                       @"E9967A", @"darksalmon",
                       @"8FBC8F", @"darkseagreen",
                       @"483D8B", @"darkslateblue",
                       @"2F4F4F", @"darkslategray",
                       @"2F4F4F", @"darkslategrey",
                       @"00CED1", @"darkturquoise",
                       @"9400D3", @"darkviolet",
                       @"FF1493", @"deeppink",
                       @"00BFFF", @"deepskyblue",
                       @"696969", @"dimgray",
                       @"696969", @"dimgrey",
                       @"1E90FF", @"dodgerblue",
                       @"B22222", @"firebrick",
                       @"FFFAF0", @"floralwhite",
                       @"228B22", @"forestgreen",
                       @"FF00FF", @"fuchsia",
                       @"DCDCDC", @"gainsboro",
                       @"F8F8FF", @"ghostwhite",
                       @"FFD700", @"gold",
                       @"DAA520", @"goldenrod",
                       @"808080", @"gray",
                       @"808080", @"grey",
                       @"008000", @"green",
                       @"ADFF2F", @"greenyellow",
                       @"F0FFF0", @"honeydew",
                       @"FF69B4", @"hotpink",
                       @"CD5C5C", @"indianred",
                       @"4B0082", @"indigo",
                       @"FFFFF0", @"ivory",
                       @"F0E68C", @"khaki",
                       @"E6E6FA", @"lavender",
                       @"FFF0F5", @"lavenderblush",
                       @"7CFC00", @"lawngreen",
                       @"FFFACD", @"lemonchiffon",
                       @"ADD8E6", @"lightblue",
                       @"F08080", @"lightcoral",
                       @"E0FFFF", @"lightcyan",
                       @"FAFAD2", @"lightgoldenrodyellow",
                       @"D3D3D3", @"lightgray",
                       @"D3D3D3", @"lightgrey",
                       @"90EE90", @"lightgreen",
                       @"FFB6C1", @"lightpink",
                       @"FFA07A", @"lightsalmon",
                       @"20B2AA", @"lightseagreen",
                       @"87CEFA", @"lightskyblue",
                       @"778899", @"lightslategray",
                       @"778899", @"lightslategrey",
                       @"B0C4DE", @"lightsteelblue",
                       @"FFFFE0", @"lightyellow",
                       @"00FF00", @"lime",
                       @"32CD32", @"limegreen",
                       @"FAF0E6", @"linen",
                       @"FF00FF", @"magenta",
                       @"800000", @"maroon",
                       @"66CDAA", @"mediumaquamarine",
                       @"0000CD", @"mediumblue",
                       @"BA55D3", @"mediumorchid",
                       @"9370D8", @"mediumpurple",
                       @"3CB371", @"mediumseagreen",
                       @"7B68EE", @"mediumslateblue",
                       @"00FA9A", @"mediumspringgreen",
                       @"48D1CC", @"mediumturquoise",
                       @"C71585", @"mediumvioletred",
                       @"191970", @"midnightblue",
                       @"F5FFFA", @"mintcream",
                       @"FFE4E1", @"mistyrose",
                       @"FFE4B5", @"moccasin",
                       @"FFDEAD", @"navajowhite",
                       @"000080", @"navy",
                       @"FDF5E6", @"oldlace",
                       @"808000", @"olive",
                       @"6B8E23", @"olivedrab",
                       @"FFA500", @"orange",
                       @"FF4500", @"orangered",
                       @"DA70D6", @"orchid",
                       @"EEE8AA", @"palegoldenrod",
                       @"98FB98", @"palegreen",
                       @"AFEEEE", @"paleturquoise",
                       @"D87093", @"palevioletred",
                       @"FFEFD5", @"papayawhip",
                       @"FFDAB9", @"peachpuff",
                       @"CD853F", @"peru",
                       @"FFC0CB", @"pink",
                       @"DDA0DD", @"plum",
                       @"B0E0E6", @"powderblue",
                       @"800080", @"purple",
                       @"FF0000", @"red",
                       @"BC8F8F", @"rosybrown",
                       @"4169E1", @"royalblue",
                       @"8B4513", @"saddlebrown",
                       @"FA8072", @"salmon",
                       @"F4A460", @"sandybrown",
                       @"2E8B57", @"seagreen",
                       @"FFF5EE", @"seashell",
                       @"A0522D", @"sienna",
                       @"C0C0C0", @"silver",
                       @"87CEEB", @"skyblue",
                       @"6A5ACD", @"slateblue",
                       @"708090", @"slategray",
                       @"708090", @"slategrey",
                       @"FFFAFA", @"snow",
                       @"00FF7F", @"springgreen",
                       @"4682B4", @"steelblue",
                       @"D2B48C", @"tan",
                       @"008080", @"teal",
                       @"D8BFD8", @"thistle",
                       @"FF6347", @"tomato",
                       @"40E0D0", @"turquoise",
                       @"EE82EE", @"violet",
                       @"F5DEB3", @"wheat",
                       @"FFFFFF", @"white",
                       @"F5F5F5", @"whitesmoke",
                       @"FFFF00", @"yellow",
                       @"9ACD32", @"yellowgreen",
                       nil];
    });
    NSString *hexString = [colorDict objectForKey:[colorName lowercaseString]];
    return YD_CreateColorWithHexString(hexString);
}

UIColor *CreateColorWithRGBName(NSString *rgbName) {
    NSString * rgbN = [rgbName stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"rbg() "]];
    NSArray* rgb = [rgbN componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
    
    if ([rgb count] != 3)
    {
        // Incorrect syntax
        return nil;
    }
    
    CGFloat red = [[rgb objectAtIndex:0] floatValue] / 255;
    CGFloat green = [[rgb objectAtIndex:1] floatValue] / 255;
    CGFloat blue = [[rgb objectAtIndex:2] floatValue] / 255;
    CGFloat alpha = 1.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

UIColor* CreateColorWithRGBAName(NSString *rgbaName) {
    NSString *rgbaN = [rgbaName stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"rgba() "]];
    NSArray *rgba = [rgbaN componentsSeparatedByString:@","];
    
    if ([rgba count] != kGRBComponentsNum) {
        // Incorrect syntax
        return nil;
    }
    
    CGFloat red = (CGFloat)[[rgba objectAtIndex:0] floatValue] / 255;
    CGFloat green = [[rgba objectAtIndex:1] floatValue] / 255;
    CGFloat blue = [[rgba objectAtIndex:2] floatValue] / 255;
    CGFloat alpha = [[rgba objectAtIndex:3] floatValue];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

// strong from color
NSString* HexStringFromColor(UIColor *color) {
    CGColorRef cgColor = color.CGColor;
    size_t count = CGColorGetNumberOfComponents(cgColor); //color components number
    const CGFloat *components = CGColorGetComponents(cgColor);
    static NSString *stringFormat = @"%02x%02x%02x";
    if (count == kGrayScaleComponentsNum) {
        return HexStrigFromColorByGrayScale(components, stringFormat);
    }
    else if (count == 4) {
        return HexStringFromColorByRGB(components, stringFormat);
    }
    return nil;
}

NSString* HexStrigFromColorByGrayScale(CGFloat *components, NSString *stringFormat) {
//    from the zero address
    NSUInteger white = (NSUInteger)(components[0] *(CGFloat)255);
    return [NSString stringWithFormat:stringFormat, white,white,white];
}

NSString* HexStringFromColorByRGB(CGFloat *components, NSString *stringFormat) {
    return [NSString stringWithFormat:stringFormat,(NSUInteger)(components[0] *(CGFloat)255.f),(NSUInteger)(components[1] *(CGFloat)255.f),(NSUInteger)(components[2] *(CGFloat)255.f)];
}

@implementation YDExtension

@end


@implementation NSString (YDExtension)

- (BOOL)yd_isNumeric {
    const char *s = [self UTF8String];
    for (size_t i=0;i<strlen(s);i++) {
        if ((s[i]<'0' || s[i]>'9') && (s[i] != '.')) {
            return NO;
        }
    }
    return YES;
}

@end
