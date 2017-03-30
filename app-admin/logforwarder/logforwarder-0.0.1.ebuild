EAPI=5

PYTHON_COMPAT=( python3_4 python3_5 python3_6 )

inherit user eutils distutils-r1 autotools

DESCRIPTION="Yet another logforwarder"
HOMEPAGE=""
SRC_URI="https://packages.ipso.cx/logforwarder/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/msgpack"
RDEPEND=""

#pkg_preinst() {
#    ebegin "Creating logforwarder user and group"
#    enewgroup logforwarder
#    enewuser logforwarder -1 -1 /dev/null logforwarder
#}

src_install() {
    distutils-r1_src_install
    newinitd "${FILESDIR}"/logforwarder.initd logforwarder
    newconfd "${FILESDIR}"/logforwarder.confd logforwarder
}

