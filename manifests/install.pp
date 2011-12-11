class pushup::install {
    package { $pushup::params::package_name:
        ensure => present,
    }
}
