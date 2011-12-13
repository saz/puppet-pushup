class pushup::service {
    service { $pushup::params::service_name:
        ensure     => $pushup::service_disable ? {
            true  => stopped,
            false => $pushup::ensure ? {
                absent  => stopped,
                present => $pushup::service_ensure,
            },
        },
        enable     => $pushup::service_disable ? {
            true  => false,
            false => $pushup::ensure ? {
                absent  => false,
                present => $pushup::service_onboot,
            },
        },
        hasstatus  => false,
        hasrestart => true,
        require    => Class['pushup::config'],
    }
}
