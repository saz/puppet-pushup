class pushup::service {
    service { $pushup::params::service_name:
        ensure     => running,
        enable     => true,
        hasstatus  => false,
        hasrestart => true,
        require    => Class['pushup::config'],
    }
}
