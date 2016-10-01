# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Created by Martin Kupec

EAPI=4

inherit user eutils python autotools

DESCRIPTION="Cloud file syncing software"
HOMEPAGE="http://www.seafile.com"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}-server.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="console server client python riak fuse"

DEPEND="
	>=dev-lang/python-2.5[sqlite]
	server? ( >=net-libs/libevhtp-1.1.7 )
	sys-devel/gettext
	virtual/pkgconfig
	dev-libs/jansson
	dev-libs/libevent
	fuse? ( sys-fs/fuse )
	client? ( =net-libs/ccnet-6.0.0[client] )
	server? ( =net-libs/ccnet-6.0.0[server] )"
RDEPEND=""

S=${WORKDIR}/${PN}-${PV}-server

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

pkg_preinst() {
	if use server ; then
		enewgroup seafile
		enewuser seafile -1 /bin/bash /var/lib/seafile seafile
	fi
}

src_prepare() {
	./autogen.sh || die "src_prepare failed"
}

src_configure() {
	CFLAGS="-I /usr/include/evhtp/"
	econf \
		$(use_enable fuse) \
		$(use_enable riak) \
		$(use_enable client) \
		$(use_enable server) \
		$(use_enable python) \
		$(use_enable console)
}

src_compile() {
	append-flags "-I /usr/include/evhtp/"
	# dev-lang/vala does not provide a valac symlink
	mkdir ${S}/tmpbin
	ln -s $(echo $(whereis valac-) | grep -oE "[^[[:space:]]*$") ${S}/tmpbin/valac
	PATH="${S}/tmpbin/:$PATH" emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install
	SEAFILE_SHARE_PATH="/usr/share/seafile"
	insinto ${SEAFILE_SHARE_PATH}/${PV}
	doins -r ${S}/scripts
	dodoc ${S}/doc/cli-readme.txt
	doman ${S}/doc/*.1
	if use server ; then
		newinitd "${FILESDIR}"/seafile-server.initd seafile-server \
			|| die "Init script installation failed"
	fi
}
