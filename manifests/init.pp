# Class: pushup
#
# This module manages pushup
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class pushup ($bindAddress = $::ipaddress, $adminBindAddress = '127.0.0.1', $adminPassword = 'password', $host_name = $::fqdn) {
    include pushup::params, pushup::install, pushup::config, pushup::service
}
