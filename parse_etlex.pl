#!/usr/bin/perl
# parse_etlex.pl: prepare data for creating dictionary database
# usage: ./parse_etlex.pl etlex.utf-8 > etlex.c5
# by Poonlap Veerathanabutr <poonlap@linux.thai.net>
# $Id: parse_etlex.pl,v 1.1 2004-06-17 16:44:35 poonlap Exp $


use strict;
use XML::Parser;


my $file = shift;
my %record;
my @present_tag;

my $parser = new XML::Parser( ErrorContext => 2 );
$parser->setHandlers (
		      Char => \&Char_handler,
		      End => \&End_handler,
		      Start => \&Start_handler
		      );
sub Char_handler {
    my ($expat,$data) = @_;
    my $tag = $present_tag[$#present_tag];
    $record{$tag} = $data;
    
}


##
## Doc 
##
sub Start_handler {
    my $expat = shift;
    my $element = shift;
    if( $element eq 'Doc' ){
	print "_____\n\n";
	push( @present_tag, "Doc");
    } else {
	push( @present_tag, $element);	
    }
}
sub End_handler {
    my $expat = shift;
    my $element = shift;
    if( $element eq 'Doc' ){
	print "$record{'esearch'}\n";
	print "$record{'eentry'} [$record{'ecat'}]\n";
	print "\t$record{'tentry'}\n";
	if( defined $record{'ethai'} ){
	    print "\t$record{'ethai'}\n\n";
	}
	if( defined $record{'eant'} ){
	    print "\tanonym: $record{'eant'}\n";
	}
	if( defined $record{'esyn'} ){
	    print "\tsynonym: $record{'esyn'}\n";
	}
	
	undef %record;
	pop @present_tag;
    } else {
	pop @present_tag;
    }
}

$parser->parsefile( $file);
