EAPI=5
USE_RUBY="ruby23 ruby24"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="Changelog README.md"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

inherit ruby-fakegem

DESCRIPTION="A framework to implement robust multiprocess servers"
HOMEPAGE="https://github.com/fluent/serverengine"
LICENSE="Apache-2.0"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ruby_add_rdepend ">=dev-ruby/sigdump-0.2.2:0"

ruby_add_bdepend "test? ( dev-ruby/bundler )"

each_ruby_test() {
	# The specs spawn ruby processes with bundler support
	${RUBY} -S bundle exec rspec-2 spec || die
}
