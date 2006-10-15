#!/usr/bin/perl
# parse_telex.pl: prepare data for creating dictionary database
# usage: ./parse_telex.pl telex.utf-8 > telex.c5
# by Poonlap Veerathanabutr <poonlap@linux.thai.net>
# $Id: parse_telex.pl,v 1.2 2006-10-15 11:27:25 thep Exp $


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
	print "$record{'tsearch'}\n";
	print "$record{'tentry'} [$record{'tcat'}]\n";
	print "\t$record{'eentry'}\n";
	if( defined $record{'tenglish'} ){
	    print "\t$record{'tenglish'}\n\n";
	}
	if( defined $record{'tnum'} ){
	    print "[\t$record{'tnum'}]\n";
	}
	if( defined $record{'tdef'} ){
	    print "\t$record{'tdef'}\n\n";
	}
	if( defined $record{'tsample'} ){
	    print "\tSample: $record{'tsample'}\n\n";
	}
	if( defined $record{'tant'} ){
	    print "\tantonym: $record{'tant'}\n";
	}
	if( defined $record{'tsyn'} ){
	    print "\tsynonym: $record{'tsyn'}\n";
	}
	if( defined $record{'notes'} ){
	    print "Note: $record{'notes'}\n";
	}

	
	undef %record;
	pop @present_tag;
    } else {
	pop @present_tag;
    }
}

$parser->parsefile( $file);
