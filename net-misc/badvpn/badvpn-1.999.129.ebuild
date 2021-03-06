EAPI="2"

inherit cmake-utils

MY_PV="${PV/_rc/rc}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Peer-to-peer VPN software"
HOMEPAGE="http://code.google.com/p/badvpn/"
SRC_URI="https://github.com/ambrop72/badvpn/archive/${MY_PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 arm x86"
SLOT="26"
IUSE="debug +badvpn +ncd +tun2socks +udpgw"

RDEPEND="
	badvpn? ( dev-libs/openssl )
	ncd? ( dev-libs/openssl )
	badvpn? ( dev-libs/nss )
	ncd? (
		virtual/udev
		sys-apps/iproute2
		net-firewall/iptables
		net-wireless/wpa_supplicant
	)
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build badvpn CLIENT)
		$(cmake-utils_use_build badvpn SERVER)
		$(cmake-utils_use_build badvpn FLOODER)
		$(cmake-utils_use_build ncd NCD)
		$(cmake-utils_use_build tun2socks TUN2SOCKS)
		$(cmake-utils_use_build udpgw UDPGW)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

        if use badvpn; then
                newinitd "${FILESDIR}/${PN}-server.init" "${PN}-server"
                newconfd "${FILESDIR}/${PN}-server.conf" "${PN}-server"
        fi

	if use ncd; then
		newinitd "${FILESDIR}/${PN}-ncd.init" "${PN}-ncd"
		newconfd "${FILESDIR}/${PN}-ncd.conf" "${PN}-ncd"
	fi
}
