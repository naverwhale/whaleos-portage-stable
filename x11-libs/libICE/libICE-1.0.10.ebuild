# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

XORG_MULTILIB=yes
inherit xorg-3

DESCRIPTION="X.Org Inter-Client Exchange library"

KEYWORDS="*"
IUSE="ipv6"

DEPEND="x11-base/xorg-proto
	x11-libs/xtrans"
RDEPEND="${DEPEND}
	elibc_glibc? ( dev-libs/libbsd )"

src_configure() {
	local XORG_CONFIGURE_OPTIONS=(
		$(use_enable ipv6)
		--disable-docs
		--disable-specs
		--without-fop
	)
	xorg-3_src_configure
}
