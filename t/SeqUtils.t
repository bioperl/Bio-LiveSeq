# -*-Perl-*- Test Harness script for Bioperl
# $Id$

use strict;

BEGIN {
    use lib '.';
    use Bio::Root::Test;

    test_begin(-tests => 6);

    use_ok('Bio::PrimarySeq');
    use_ok('Bio::SeqUtils');
    use_ok('Bio::LiveSeq::Mutation');
}

#
# Mutate
#

my $string1 = 'aggt';
my $seq = Bio::PrimarySeq->new('-seq'=> 'aggt',
                               '-alphabet'=>'dna',
                               '-id'=>'test3');

# point
Bio::SeqUtils->mutate($seq,
                      Bio::LiveSeq::Mutation->new(-seq => 'c',
                                                  -pos => 3
                                                 )
                     );
is $seq->seq, 'agct';

# insertion and deletion
my @mutations = (
                 Bio::LiveSeq::Mutation->new(-seq => 'tt',
                                             -pos => 2,
                                             -len => 0
                                            ),
                 Bio::LiveSeq::Mutation->new(-pos => 2,
                                             -len => 2
                                            )
);

Bio::SeqUtils->mutate($seq, @mutations);
is $seq->seq, 'agct';

# insertion to the end of the sequence
Bio::SeqUtils->mutate($seq,
                      Bio::LiveSeq::Mutation->new(-seq => 'aa',
                                                  -pos => 5,
                                                  -len => 0
                                                 )
                     );
is $seq->seq, 'agctaa';
