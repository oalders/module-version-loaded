use strict;
use warnings;
package Module::Version::Loaded;

use Module::Version 0.12 qw( get_version );
use Sub::Exporter -setup =>
    { exports => [ 'versioned_inc', 'versioned_modules' ] };

sub versioned_inc {
    my %versioned;
    foreach my $module ( keys %INC ) {
        my ( $version, undef ) = _module_version($module);
        $versioned{$module} = $version;
    }
    return %versioned;
}

sub versioned_modules {
    my %versioned;
    foreach my $file ( keys %INC ) {
        my ( $version, $module ) = _module_version($file);
        $versioned{$module} = $version;
    }
    return %versioned;
}

sub _module_version {
    my $module = shift;
    $module =~ s{/}{::}g;
    $module =~ s{\.pm\z}{};
    return ( get_version($module), $module );
}
1;

__END__
# ABSTRACT: Get a versioned list of currently loaded modules

=head1 SYNOPSIS

    use Module::Version::Loaded qw( versioned_modules );

    my %modules = versioned_modules();
    # %modules contains: ( Foo::Bar => 0.01, Bar::Foo => 1.99, ... )

=head1 DESCRIPTION

BETA BETA BETA

This module exists solely to give you a version of your %INC which includes the
versions of the modules you have loaded.  This is helpful when troubleshooting
different environments.  It makes it easier to see, at glance, which versions
of modules you have actually loaded.

=head1 FUNCTIONS

=head2 versioned_modules

Returns a C<Hash> of module versions, which is keyed on module name.

        use Module::Version::Loaded qw( versioned_modules );
        my %modules = versioned_modules();
        # contains:
        ...
        vars                         => 1.03,
        version                      => 0.9912,
        version::regex               => 0.9912,
        version::vxs                 => 0.9912,
        ...

=head2 versioned_inc

Returns a C<Hash> of module versions, which uses the same keys as %INC.  This
makes it easier to compare this data which %INC, since both Hashes will share
the same keys.

        use Module::Version::Loaded qw( versioned_inc );
        my %inc = versioned_inc();
        # contains:
        ...
        version.pm                    => 0.9912,
        version/regex.pm              => 0.9912,
        version/vxs.pm                => 0.9912,
        warnings.pm                   => 1.18,
        ...

        foreach my $key ( %INC ) {
            print "$key $INC{$key} $inc{$key}\n";
        }
