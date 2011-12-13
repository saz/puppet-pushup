class pushup::install {
    package { $pushup::params::package_name:
        ensure => $pushup::ensure ? {
            absent  => absent,
            default => $pushup::package_ensure ? {
                latest  => latest,
                absent  => absent,
                default => present,
            },
        },
    }
}
