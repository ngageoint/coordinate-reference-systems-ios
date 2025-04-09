//
//  CRSTextReader.m
//  crs-ios
//
//  Created by Brian Osborn on 7/22/21.
//  Copyright © 2021 NGA. All rights reserved.
//

#import <CoordinateReferenceSystems/CRSTextReader.h>
#import <CoordinateReferenceSystems/CRSTextUtils.h>

@interface CRSTextReader()

/**
 * Text
 */
@property (nonatomic, strong) NSString *text;

/**
 * Next tokens cache for peeks
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *nextTokens;

/**
 * Next character number cache for between token caching
 */
@property (nonatomic) int nextCharacterNum;

@end

@implementation CRSTextReader

+(CRSTextReader *) createWithText: (NSString *) text{
    return [[CRSTextReader alloc] initWithText:text];
}

+(CRSTextReader *) createWithText: (NSString *) text andIncludeQuotes: (BOOL) includeQuotes{
    return [[CRSTextReader alloc] initWithText:text andIncludeQuotes:includeQuotes];
}

-(instancetype) initWithText: (NSString *) text{
    return [self initWithText:text andIncludeQuotes:NO];
}

-(instancetype) initWithText: (NSString *) text andIncludeQuotes: (BOOL) includeQuotes{
    self = [super init];
    if(self != nil){
        _nextTokens = [NSMutableArray array];
        _text = text;
        _nextCharacterNum = 0;
        _includeQuotes = includeQuotes;
    }
    return self;
}

-(NSString *) text{
    return _text;
}

-(void) reset{
    [_nextTokens removeAllObjects];
    _nextCharacterNum = 0;
}

-(NSString *) readToken{
    return [self readTokenWithCache:YES];
}

/**
 * Read the next token. Ignores whitespace until a non whitespace character
 * is encountered. Returns a contiguous block of token characters ( [a-z] |
 * [A-Z] | [0-9] | - | . | + | : | _ ) or a non whitespace single character.
 *
 * @param cache
 *            true to read from cached peeks, false to force read
 *
 * @return token
 */
-(NSString *) readTokenWithCache: (BOOL) cache{

    NSString *token = nil;

    // Get the next token, cached or read
    if(cache && _nextTokens.count > 0){
        token = [_nextTokens objectAtIndex:0];
        [_nextTokens removeObjectAtIndex:0];
    }else {

        NSMutableString *buildToken = nil;
        BOOL isQuote = NO;
        BOOL previousCharQuote = NO;

        // Continue while characters are left
        while (_nextCharacterNum < _text.length) {
            
            unichar character = [_text characterAtIndex:_nextCharacterNum];

            // Check if not the first character in the token
            if (buildToken != nil) {

                // If in a quoted string
                if(isQuote){
                    BOOL charQuote = [self isQuoteCharacter:character];
                    if(previousCharQuote){
                        if(charQuote){
                            [buildToken appendFormat:@"%C", character];
                            previousCharQuote = NO;
                        }else{
                            // End of quoted string found at previous character
                            break;
                        }
                    }else if(charQuote){
                        previousCharQuote = YES;
                    }else{
                        [buildToken appendFormat:@"%C", character];
                    }
                }else if([self isTokenCharacter:character]){
                    // Append token characters
                    [buildToken appendFormat:@"%C", character];
                }else{
                    // Complete the token
                    break;
                }

            } else if (![NSCharacterSet.whitespaceAndNewlineCharacterSet characterIsMember:character]) {

                // First non whitespace character in the token
                buildToken = [NSMutableString string];
                if([self isQuoteCharacter:character]){
                    isQuote = YES;
                }else{
                    
                    [buildToken appendFormat:@"%C", character];
                    
                    if(![self isTokenCharacter:character]){
                        // Complete token if a single character token
                        _nextCharacterNum++;
                        break;
                    }
                }
            }

            // Continue to the next character
            _nextCharacterNum++;
        }

        if (buildToken != nil) {
            token = buildToken;
            if(isQuote && _includeQuotes){
                token = [NSString stringWithFormat:@"\"%@\"", token];
            }
        }

    }
    return token;
}


-(NSString *) peekToken{
    return [self peekTokenAtNum:1];
}

-(NSString *) peekTokenAtNum: (int) num{
    for(int i = 1; i <= num; i++){
        if(_nextTokens.count < i){
            NSString *token = [self readTokenWithCache:NO];
            if(token != nil){
                [_nextTokens addObject:token];
            }else{
                break;
            }
        }
    }
    NSString *token = nil;
    if(num <= _nextTokens.count){
        token = [_nextTokens objectAtIndex:num - 1];
    }
    return token;
}

-(void) pushToken: (NSString *) token{
    [_nextTokens insertObject:token atIndex:0];
}

-(NSString *) readExpectedToken{
    NSString *token = [self readToken];
    if(token == nil){
        [NSException raise:@"Unexpected End" format:@"Unexpected end of text, null token"];
    }
    return token;
}

-(NSString *) peekExpectedToken{
    return [self peekExpectedTokenAtNum:1];
}

-(NSString *) peekExpectedTokenAtNum: (int) num{
    NSString *token = [self peekExpectedTokenAtNum:num];
    if(token == nil){
        [NSException raise:@"Unexpected End" format:@"Unexpected end of text, null token"];
    }
    return token;
}

-(double) readNumber{
    NSString *token = [self readExpectedToken];
    return [CRSTextUtils doubleFromString:token];
}

-(double) readUnsignedNumber{
    double number = [self readNumber];
    if(number < 0){
        [NSException raise:@"Invalid Number" format:@"Invalid unsigned number. found: %f", number];
    }
    return number;
}

-(int) readInteger{
    return [CRSTextUtils intFromString:[self readExpectedToken]];
}

-(int) readUnsignedInteger{
    int number = [self readInteger];
    if(number < 0){
        [NSException raise:@"Invalid Number" format:@"Invalid unsigned integer. found: %d", number];
    }
    return number;
}

/**
 * Check if the character is a contiguous block token character: ( [a-z] |
 * [A-Z] | [0-9] | - | . | + | : | _ )
 *
 * @param c
 *            character
 * @return true if token character
 */
-(BOOL) isTokenCharacter: (unichar) c{
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
            || (c >= '0' && c <= '9') || c == '-' || c == '.' || c == '+'
            || c == ':' || c == '_';
}

/**
 * Check if the character is a quote character
 *
 * @param c
 *            character
 * @return true if quote character
 */
-(BOOL) isQuoteCharacter: (unichar) c{
    BOOL quote = c == '"';
    if(!quote){
        NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"“”„”«»「」"];
        quote = [charset characterIsMember:c];
    }
    return quote;
}

@end
