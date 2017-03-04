EAPI=5

USE_RUBY="ruby23 ruby24"

inherit multilib ruby-fakegem

DESCRIPTION="A fast strptime engine which uses VM"
HOMEPAGE="https://rubygems.org/gems/strptime/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

each_ruby_configure() {
  ${RUBY} -Cext/strptime extconf.rb || die
}

each_ruby_compile() {
  emake -Cext/strptime V=1
  cp ext/strptime/*$(get_modname) lib/strptime || die
}
