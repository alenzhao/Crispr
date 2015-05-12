## no critic (RequireUseStrict, RequireUseWarnings, RequireTidyCode)
package Crispr::Allele;
## use critic

# ABSTRACT: Allele object - representing a sequence variant

use warnings;
use strict;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

subtype 'Crispr::Allele::DNA',
    as 'Str',
    where { my $ok = 1;
            $ok = 0 if $_ eq '';
            my @bases = split //, $_;
            foreach my $base ( @bases ){
                if( $base !~ m/[ACGT]/ ){
                    $ok = 0;
                }
            }
            return $ok;
    },
    message { "Not a valid DNA sequence.\n" };

=method new

  Usage       : my $allele = Crispr::Allele->new(
					db_id => undef,
                    chr => 'Zv9_scaffold12',
					pos => 25364,
					ref_allele => 'GT',
					alt_allele => 'GACAG',
                    sa_number => 'sa564',
                    percent_of_reads => 10.5,
                    kaspar_assay => $kasp_assay,
                );
  Purpose     : Constructor for creating Sample objects
  Returns     : Crispr::Allele object
  Parameters  : db_id => Int,
                chr => Str,
                pos => Int,
                ref_allele => Str,
                alt_allele => Str,
                sa_number => Str,
                percent_of_reads => Num,
                kaspar_assay => $kasp_assay,
  Throws      : If parameters are not the correct type
  Comments    : None

=cut

=method db_id

  Usage       : $allele->db_id;
  Purpose     : Getter/Setter for Sample db_id attribute
  Returns     : Int (can be undef)
  Parameters  : None
  Throws      : 
  Comments    : 

=cut

has 'db_id' => (
    is => 'rw',
    isa => 'Maybe[Int]',
);

=method chr

  Usage       : $allele->chr;
  Purpose     : Getter for Sample chr attribute
  Returns     : Str
  Parameters  : None
  Throws      : If input is given
  Comments    : 

=cut

has 'chr' => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

=method pos

  Usage       : $allele->pos;
  Purpose     : Getter for pos attribute
  Returns     : Int
  Parameters  : None
  Throws      : If input is given
  Comments    : 

=cut

has 'pos' => (
    is => 'ro',
    isa => 'Int',
    required => 1,
);

=method ref_allele

  Usage       : $allele->ref_allele;
  Purpose     : Getter for ref_allele attribute
  Returns     : Str (must be valid DNA sequence)
  Parameters  : None
  Throws      : If input is given
                If input is not a valid DNA sequence (ACGT)
  Comments    : 

=cut

has 'ref_allele' => (
    is => 'ro',
	isa =>  'Crispr::Allele::DNA',
    required => 1,
);

=method alt_allele

  Usage       : $allele->alt_allele;
  Purpose     : Getter for alt_allele attribute
  Returns     : Str (must be valid DNA sequence)
  Parameters  : None
  Throws      : If input is given
                If input is not a valid DNA sequence (ACGT)
  Comments    : 

=cut

has 'alt_allele' => (
    is => 'ro',
	isa =>  'Crispr::Allele::DNA',
    required => 1,
);

=method sa_number

  Usage       : $allele->sa_number;
  Purpose     : Getter for Sample sa_number attribute
  Returns     : Str
  Parameters  : None
  Throws      : If input is given
  Comments    : 

=cut

has 'sa_number' => (
    is => 'ro',
    isa => 'Maybe[Str]',
);

=method percent_of_reads

  Usage       : $allele->percent_of_reads;
  Purpose     : Getter for Sample percent_of_reads attribute
  Returns     : Num
  Parameters  : None
  Throws      : If input is given
  Comments    : 

=cut

has 'percent_of_reads' => (
    is => 'rw',
    isa => 'Num',
);

=method kaspar_assay

  Usage       : $allele->kaspar_assay;
  Purpose     : Getter for Sample kaspar_assay attribute
  Returns     : Crispr::Kasp object
  Parameters  : None
  Throws      : If input is given
  Comments    : 

=cut

has 'kaspar_assay' => (
    is => 'rw',
    isa => 'Maybe[ Crispr::Kasp ]',
    handles => {
        kaspar_id => 'assay_id',
        kaspar_rack_id => 'rack_id',
        kaspar_row_id => 'row_id',
        kaspar_col_id => 'col_id',
    },
);

=method allele_name

  Usage       : $allele->allele_name;
  Purpose     : Getter for Allele name attribute
  Returns     : Str  (CHR:POS:REF:ALT)
  Parameters  : None
  Throws      : 
  Comments    : 

=cut

sub allele_name {
    my ( $self, ) = @_;
    return join(":", $self->chr, $self->pos, $self->ref_allele, $self->alt_allele, );
}

__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=head1 SYNOPSIS
 
    use Crispr::Allele;
    my $allele = Crispr::Allele->new(
        db_id => undef,
        chr => 'Zv9_scaffold12',
        pos => 25364,
        ref_allele => 'GT',
        alt_allele => 'GACAG',
        sa_number => 'sa564',
        percent_of_reads => 10.5,
        kaspar_assay => $kasp_assay,
    );    
    
=head1 DESCRIPTION
 
Objects of this class represent a variant allele.

=head1 DIAGNOSTICS


=head1 DEPENDENCIES
 
 Moose
 
=head1 INCOMPATIBILITIES
 
