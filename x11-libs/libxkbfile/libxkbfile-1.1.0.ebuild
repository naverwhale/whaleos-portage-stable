# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
XORG_MULTILIB=yes
inherit xorg-3

DESCRIPTION="X.Org xkbfile library"

KEYWORDS="*"
IUSE=""

RDEPEND="x11-libs/libX11[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	x11-base/xorg-proto"
