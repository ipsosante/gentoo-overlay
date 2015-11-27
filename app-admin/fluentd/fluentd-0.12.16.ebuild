# Copyright 2008-2011 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit user

USE_RUBY="ruby22"

USE_RUBY="ruby22"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_EXTRADOC=""
RUBY_FAKEGEM_EXTRAINSTALL=""
inherit ruby-fakegem

DESCRIPTION="Fluentd is a log collector daemon written in Ruby"
HOMEPAGE="http://fluentd.org"
SRC_URI="https://github.com/fluent/${PN}/archive/v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/coolio
		  >=dev-ruby/json-1.4.3
		  >=dev-ruby/msgpack-0.7.0
		  dev-ruby/yajl-ruby
		  dev-ruby/http_parser_rb
		  dev-ruby/sigdump
		  dev-ruby/tzinfo"


all_ruby_install() {
  all_fakegem_install

  # Location of conf files
  keepdir /etc/"${PN}"

  newinitd "${FILESDIR}"/fluentd.initd fluentd
  newconfd "${FILESDIR}"/fluentd.confd fluentd
}

pkg_setup() {
  ebegin "Creating nginx user and group"
  enewgroup fluentd
  enewuser fluentd -1 -1 /dev/null fluentd
}
