# Class: xss_validator
# ===========================
#
# Used to install the xss_validator tool on Kali.
#
# Parameters
# ----------
#
# * `install`
# The directory where you want to install xss_validator
#
# Variables
# ----------
#
# N/A
#
# Examples
# --------
#
# @example
#
#    class { 'xss_validator':
#      install_location => '/opt/xss_validator',
#    }
#
# Authors
# -------
#
# l50 <jayson.e.grace@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2016 l50
#
class xss_validator(
  $install_location=$xss_validator::params::install_location,
  $commons_codec_download_location=$xss_validator::params::commons_codec_download_location,
  $commons_logging_download_location=$xss_validator::params::commons_logging_download_location,
  $fluent_hc_download_location=$xss_validator::params::fluent_hc_download_location,
  $httpclient_download_location=$xss_validator::params::httpclient_download_location,
  $httpclient_cache_download_location=$xss_validator::params::httpclient_cache_download_location,
  $httpcore_download_location=$xss_validator::params::httpcore_download_location,
  $httpmime_download_location=$xss_validator::params::httpmime_download_location,
  $dependencies=$xss_validator::params::dependencies,
) inherits xss_validator::params {

  package { [
    'ant',
  ]:
    ensure => installed,
  }

  include stdlib
  include git
  include phantomjs

  exec { "apt-update":
    command => "/usr/bin/apt-get update"
  }

  Exec["apt-update"] -> Package <| |>

  vcsrepo { $install_location:
    ensure   => present,
    provider => git,
    source   => 'git://github.com/l50/xssValidator.git',
    require  => Class['git'],
    }->

    file { "$install_location/burp-extender/lib":
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    } ->

    wget::fetch { $dependencies:
      destination => "$install_location/burp-extender/lib",
    }

    exec { 'compile_xss-validator_jar':
      command => "/usr/bin/ant $install_location/burp-extender/bin/burp"
    }
}
