#!/bin/bash
#---------------------------------------------------------
# Bootstrap script to install puppet requirements
# 1.) install ruby and rubygems
# 2.) install ruby-augeas, ruby-shadow, ruby-json from rpm
# 3.) set system hostname
# 4.) install puppet yum repo
# 5.) install puppet
# 6.) install hiera data files
#---------------------------------------------------------
# required param to determine node
SERVER=$1
# optional param to run puppet in noop mode
ACTION=$2

DESTDIR="/tmp/puppet-modules"
PUPPETROOT=/etc/puppet

if [ "$2" == "no" ];then
        NOOP='--noop'
else
        NOOP=""
fi

function setHostname () {
  # fix hostname for puppet
   hostname ${SERVER}
   sed -i "s/HOSTNAME/$SERVER/g" scripts/etc.hosts

   cp scripts/etc.hosts /etc/hosts
}

function hieraSetup() {
  if [ ! -d $PUPPETROOT/hieradata ];then
     mkdir -p $PUPPETROOT/hieradata
  fi
   cp hiera/hiera.yaml $PUPPETROOT
   cp hiera/hieradata/*.yaml $PUPPETROOT/hieradata
}

function installPuppetRedHat () {
  TCL=tcl-8.4.13-16.fc7.x86_64.rpm
	if [ ! -f /tmp/${TCL} ];then
          pushd /tmp
          wget http://archive.fedoraproject.org/pub/archive/fedora/linux/releases/7/Everything/x86_64/os/Fedora/${TCL}
          yum install -y /tmp/${TCL}
          popd
    fi
	
  TK=tk-8.4.13-5.fc7.x86_64.rpm
	if [ ! -f /tmp/${TK} ];then
          pushd /tmp
          wget http://archive.fedoraproject.org/pub/archive/fedora/linux/releases/7/Everything/x86_64/os/Fedora/${TK}
          yum install -y /tmp/${TK}
          popd
    fi
  
  if [ ! -f /etc/yum.repos.d/puppetlabs.repo ];then
    cp scripts/puppetlabs.repo /etc/yum.repos.d
    cp scripts/rhel.repo /etc/yum.repos.d
    cp scripts/rhel-source.repo /etc/yum.repos.d
  fi
  
  yum install -y ruby
  yum install -y rubygems
	
  # install Puppet Ruby library dependencies
  RUBYSHADOW=ruby-shadow-1.4.1-2.el5.rf.x86_64.rpm
	if [ ! -f /tmp/${RUBYSHADOW} ];then
	        pushd /tmp
	        wget http://pkgs.repoforge.org/ruby-shadow/${RUBYSHADOW}
	        yum install -y /tmp/${RUBYSHADOW}
	        popd
	fi
	
  RUBYAUGEAS=ruby-augeas-0.4.1-2.el6.rfx.x86_64.rpm
	if [ ! -f /tmp/${RUBYAUGEAS} ];then
	        pushd /tmp
	        wget http://pkgs.repoforge.org/ruby-augeas/${RUBYAUGEAS}
	        yum install -y /tmp/${RUBYAUGEAS}
	        popd

	fi

  RUBYGEMJSON=rubygem-json-1.5.1-1.el5.rf.x86_64.rpm	
	if [ ! -f /tmp/${RUBYGEMJSON} ];then
          pushd /tmp
          wget http://pkgs.repoforge.org/rubygem-json/${RUBYGEMJSON}
          yum install -y /tmp/${RUBYGEMJSON}
          popd
    fi
	
  # install puppet
  yum install -y puppet
  puppet --version
}

function installPuppetUbuntu () {
  #http://projects.puppetlabs.com/projects/1/wiki/Puppet_Ubuntu
  if [ ! -f /etc/apt/sources.list.d/puppet.list ];then
    UBUNTU_REL=`lsb_release -a`
    wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
    dpkg -i puppetlabs-release-precise.deb
    apt-get update
    apt-get -y install puppet
  fi
  echo "Puppet Version:"
  puppet --version
}

function puppetApply () {
	MODULES="modules"
	puppet apply $NOOP --verbose --debug --detailed-exitcodes --modulepath $MODULES  manifests/nodes/${SERVER}.pp
}
#------------------------------------------------------------
setHostname

FLAVOR=`uname -a |grep -v ubuntu`
if [ $? -eq 1 ];then
  installPuppetUbuntu
else
  installPuppetRedHat
fi

hieraSetup


# for puppet exit codes read: http://docs.puppetlabs.com/man/apply.html
puppetApply
STATUS=$?
echo "INFO: puppet exit code is $?"
if [ $STATUS -eq 0 ];then
  echo "SUCCESS: Puppet had no changes to apply."
  exit 0
elif [ $STATUS -eq 2 ];then
  echo "SUCCESS: Puppet Successfully applied changes "
  exit 0
else
  echo "Puppet apply exit code was: $STATUS"
  echo ">>> FAILURE <<< Puppet apply had failures!"
  exit $STATUS
fi
