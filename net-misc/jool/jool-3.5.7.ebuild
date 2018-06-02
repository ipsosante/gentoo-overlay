EAPI=5

inherit linux-mod autotools

DESCRIPTION="Jool is an Open Source SIIT and NAT64 for Linux."
HOMEPAGE="https://nicmx.github.io/Jool/en/"
SRC_URI="https://github.com/NICMx/releases/raw/master/Jool/Jool-${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-apps/ethtool dev-libs/libnl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Jool-${PV}"

BUILD_TARGETS="stateless stateful"

MODULE_NAMES="jool(net:${S}/mod:${S}/mod/stateful) jool_siit(net:${S}/mod:${S}/mod/stateless)"

BUILD_PARAMS="-j1"

src_configure() {
	cd usr
        econf || die "configure failed"

	linux-mod_src_compile
}

src_compile() {
	cd usr
        emake || die "emake failed"
}

src_install() {
        cd usr
        emake DESTDIR="${D}" install || die "emake install failed"
	doman stateful/jool.8 stateless/jool_siit.8 
	linux-mod_src_install
        #insinto /lib/udev/rules.d
        #doins "${FILESDIR}/60-${PN}.rules"
        #newinitd "${FILESDIR}"/${PN}-0.40-initd smapi
	#newconfd "${FILESDIR}"/${PN}-0.40-confd smapi
}
