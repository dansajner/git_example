# Class - git_example
#
class git_example {

  package { 'git':
    ensure => installed,
  }

  $repo = '/home/vagrant/repo'

  file { ${repo}:
    ensure => directory,
    owner  => 'vagrant',
    group  => 'vagrant',
  }

  exec { "/usr/bin/git init ${repo}":
    creates => "${repo}/.git/config",
    user    => 'vagrant',
    group   => 'vagrant',
    require => [ File[ $repo ], Package[ 'git' ] ],
  }

  file { "${repo}/.git/hooks/post-commit":
    ensure  => present,
    owner   => 'vagrant',
    group   => 'vagrant',
    mode    => '0755',
    content => 'curl http://localhost:8080/job/test/build?delay=0sec',
    require => Exec[ "/usr/bin/git init ${repo}" ],
  }

}
