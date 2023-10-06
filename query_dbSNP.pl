#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

my $f1 = '/uufs/chpc.utah.edu/common/home/pezzolesi-group1/resources/annovar/hg38/hg38_avsnp150.txt';
my $f2 = './ceramideGenes_uniqSNPs.txt';

open my $dbSNP_file, '<', $f1 or die "Can't open the dbSNP file $f1: $!";

my %snpRS_hash;

#my $counter = 0;
while (my $line = <$dbSNP_file>) {

    chomp $line;
    my @line = (split('\s+', $line));
    my $position = join("_", @line[0..$#line-1]);
    my $rsid = join("_", $line[$#line]);

    #print "$position\n";

    if (exists $snpRS_hash{$position}) {
        push(@{ $snpRS_hash{$position} }, $rsid);
    } else {
        my @rsArr = ($rsid);
        $snpRS_hash{$position} = \@rsArr;
    }
    #$counter = $counter + 1;
    #if ($counter == 100) {
    #    last;
    #}
}

print Dumper(\%snpRS_hash);

my @ceraSNPs;

open my $ceramideSNPs_file, '<', $f2 or die "Can't open the ceramideSNPs file $f2: $!";

#my $counter = 0;
while (my $line = <$ceramideSNPs_file>) {
    chomp $line;
    $line = (split('\s+', $line))[0];
    print($line);
    #print ref($line)||"SCALAR", "\n";
    my @line = split('_', $line);
    my $chr = $line[0];
    my $position = $line[1];
    my $allele1 = $line[2];
    my $allele2 = $line[3];

    $chr = substr($chr, 3, 1);
    my $allele1_length = length($allele1);
    
    my $newPosition = "";
    if ($allele1_length > 1) {
        my $subtractVal = $allele1_length - 1;
        #print "Allele is length: ", $allele1_length, "\n";
        #print "Value to subract: ", $subtractVal, "\n";
        $newPosition = $position - $subtractVal;
    } else {
        $newPosition = $position;
    }

    my $newVariant = join("_", ($chr, $newPosition, $position, $allele1, $allele2));
    #my $variant = join("_", @line[0..$#line-1]);

    #print $newVariant, "\n";
    #print $variant, "\n";
    #$counter = $counter + 1;
    print($newVariant);
    push(@ceraSNPs, $newVariant);
    #if ($counter == 10) {
    #    last;
    #}
}

close $ceramideSNPs_file;

#my $counter1 = 0;
foreach my $cerasnp (@ceraSNPs) {
    #print "Ceramide SNP: $cerasnp\n";

    if (exists $snpRS_hash{$cerasnp}) {
        print join(', ', $cerasnp, @{$snpRS_hash{$cerasnp}}, "\n");
    }

    #$counter1 = $counter1 + 1;
    #if ($counter1 == 5000) {
    #    last;
    #}
}
#
#my $counter2 = 0;
#foreach my $key (keys %snpRS_hash) {
#    print "Key: $key\n";
#    $counter2 = $counter2 + 1;
#    if ($counter2 == 5000) {
#        last;
#    }
#}


#print join(", ", @ceraSNPs), "\n";
