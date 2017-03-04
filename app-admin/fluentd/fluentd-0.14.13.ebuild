EAPI=5

inherit user

USE_RUBY="ruby23 ruby24"

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
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/msgpack-0.7.0
                  dev-ruby/yajl-ruby
                  dev-ruby/coolio
                  dev-ruby/serverengine
                  dev-ruby/http_parser_rb
                  dev-ruby/sigdump
                  dev-ruby/tzinfo
                  dev-ruby/strptime"

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
