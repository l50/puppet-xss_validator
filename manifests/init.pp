# Class: xss_validator
# ===========================
#
# Used to install the xss_validator tool on Kali.
#
# Parameters
# ----------
#
# * `install_location`
# The directory where you want to install xss_validator
#
# * `commons_codec_download_location`
# The directory where you want to install the commons_codec jar file
#
# * `commons_logging_download_location`
# The directory where you want to install the commons_logging jar file
#
# * `fluent_hc_download_location`
# The directory where you want to install the fluent_hc jar file
#
# * `httpclient_download_location`
# The directory where you want to install the httpclient jar file
#
# * `httpclient_cache_download_location`
# The directory where you want to install the httpclient_cache jar file
#
# * `httpcore_download_location`
# The directory where you want to install the httpcore jar file
#
# * `httpmime_download_location`
# The directory where you want to install the httpmime jar file
#
# Requirements
# --------
#
# puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
# puppetlabs-vcsrepo - https://github.com/puppetlabs/puppetlabs-vcsrepo
# phantomjs - https://github.com/3fs/puppet-phantomjs
#
# Examples
# --------
#
#    class { 'xss_validator':
#      install_location => '/opt/xss_validator',
#    }
#
# Authors
# -------
#
# Jayson Grace <jayson.e.grace@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2016 Jayson Grace
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

  include stdlib
  include git
  include phantomjs

  package { 'ant':
    ensure => 'installed',
  }

  vcsrepo { $install_location:
    ensure   => present,
    provider => git,
    source   => 'git://github.com/l50/xssValidator.git',
    require  => Class['git'],
  } ->

  file { "$install_location/burp-extender/lib":
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  } ->

  wget::fetch { $dependencies:
    destination => "$install_location/burp-extender/lib/",
  } ->

  exec { 'compile_xss-validator_jar':
    command => '/usr/bin/ant',
    cwd     => "$install_location/burp-extender/bin/burp",
  }
}
