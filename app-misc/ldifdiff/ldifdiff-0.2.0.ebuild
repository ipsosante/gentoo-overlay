# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION=""
HOMEPAGE="https://github.com/nxadm/ldifdiff"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/go"

EGO_VENDOR=(
        "github.com/docopt/docopt.go 784ddc588536785e7299f7272f39101f7faccc3f"
)

EGO_PN="github.com/nxadm/${PN}"

inherit golang-vcs-snapshot

SRC_URI="https://github.com/nxadm/ldifdiff/archive/v${PV}.tar.gz -> ${P}.tar.gz
         ${EGO_VENDOR_URI}"

src_compile() {
	cd src/github.com/nxadm/ldifdiff/cmd || die
	export GOPATH="${S}:$(get_golibdir_gopath)"
	go build -v -o ldifdiff ldifdiff.go || die
}

src_install() {
	dobin src/github.com/nxadm/ldifdiff/cmd/ldifdiff
}
