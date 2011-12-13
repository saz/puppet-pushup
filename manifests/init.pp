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
class pushup (
    $ensure = present,
    $bindAddress = $::ipaddress,
    $adminBindAddress = '127.0.0.1',
    $adminPassword = 'password',
    $host_name = $::fqdn,
    $service_ensure = running,
    $service_onboot = true,
    $service_disable = false,
    $monitor = false,
    $monitor_tool = false,
    $firewall = false,
    $firewall_tool = false,
    $firewall_src = false,
    $firewall_dst = $::ipaddress
) {
    include pushup::params, pushup::install, pushup::config, pushup::service
}
