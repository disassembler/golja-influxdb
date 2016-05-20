class influxdb::repo {

  if $::influxdb::server::manage_repo {
    case $::osfamily {
      'Debian': {
        class { 'influxdb::repo::apt': }
      }
      'RedHat': {
        class { 'influxdb::repo::yum': }
      }
      default: {
        fail("Unsupported managed repository for osfamily: ${::osfamily}, operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports managing repos for osfamily RedHat and Debian")
      }
    }
  }
}
