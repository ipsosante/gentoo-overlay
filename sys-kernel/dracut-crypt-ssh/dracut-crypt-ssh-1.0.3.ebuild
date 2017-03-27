EAPI=6

DESCRIPTION="dracut initramfs module to start dropbear sshd during boot to enter LUKS passphrase remotely"
HOMEPAGE="https://github.com/dracut-crypt-ssh/dracut-crypt-ssh"
SRC_URI="https://github.com/dracut-crypt-ssh/dracut-crypt-ssh/archive/v1.0.3.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="net-misc/dropbear net-misc/dhcp sys-apps/iproute2 net-misc/iputils[arping]"
