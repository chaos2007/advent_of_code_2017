use strict;
use warnings;

sub parse_line { 
    my ($line) = @_;
    my @words = split / /, $line;
    my %ret_val = (
        operating_reg => $words[0],
        operation => $words[1],
        operation_amount => $words[2],
        bool_reg => $words[4],
        bool_operation => $words[5],
        bool_compare => $words[6]
        );
    return %ret_val;
}

sub perform_operation {
    my ($reg_value, $operation, $operation_amount) = @_;
    if( $operation eq "inc" ) {
        return $reg_value + $operation_amount;
    } elsif ( $operation eq "dec" ) {
        return $reg_value - $operation_amount;
    }
    return 0;
}

sub bool_check {
    my ($reg_value, $operation, $static_value) = @_;
    if( $operation eq "<" ) {
        return $reg_value < $static_value;
    } elsif(  $operation eq ">" ) {
        return $reg_value > $static_value;
    } elsif(  $operation eq "<=" ) {
        return $reg_value <= $static_value;
    } elsif(  $operation eq ">=" ) {
        return $reg_value == $static_value;
    } elsif(  $operation eq "==" ) {
        return $reg_value == $static_value;
    } elsif(  $operation eq "!=" ) {
        return $reg_value != $static_value;
    } else {
        return 0;
    }
}

use Test::More 'no_plan'; 
#
my %expected = (
    operating_reg => "b",
    operation => "inc", 
    operation_amount => 5,
    bool_reg => "a", 
    bool_operation => ">",
    bool_compare => 1 );
my %actual = parse_line('b inc 5 if a > 1');
is_deeply( \%actual, \%expected, "Should be equal.");

ok( !bool_check(4, "<", 3), "Should be false.");
ok( bool_check(3, "<", 4), "Should be true.");
is( 4, perform_operation( 2, "inc", 2), "Should increment.");
is( 2, perform_operation( 4, "dec", 2), "Should decrement.");

my $filename = 'test_input_1.txt';
if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
    my %reg_values = ();
    while (my $row = <$fh>) {
        chomp $row;
        $reg_values{$line{"bool_reg"} = 0 if !exists $reg_values{$line{"bool_reg"}};
        $reg_values{$line{"operating_reg"} = 0 if !exists $reg_values{$line{"operating_reg"}};
        print "Exists\n"    if exists $hash{$key};
        if( bool_check( $reg_values{$line{"bool_reg"}}, $line{"bool_operation"}, $line{"bool_compare"})) {
            $reg_values{$line{"operating_reg"}} = perform_operation($reg_values{$line{"operating_reg"}}, $line{"operation"}, $line{"operation_amount"});
        }
    }
} else {
    warn "Could not open file '$filename' $!";
}