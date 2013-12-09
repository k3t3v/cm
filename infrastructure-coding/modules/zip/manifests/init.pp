class zip {
  package {'unzip':
    ensure  => present,
  }
  package {'zip':
    ensure  => present,
  }
}