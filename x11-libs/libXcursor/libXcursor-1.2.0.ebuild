# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

XORG_MULTILIB=yes
inherit xorg-3

DESCRIPTION="X.Org Xcursor library"

KEYWORDS="*"
IUSE="doc"

RDEPEND=">=x11-libs/libXrender-0.9.8[${MULTILIB_USEDEP}]
	>=x11-libs/libXfixes-5.0.1[${MULTILIB_USEDEP}]
	>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

XORG_CONFIGURE_OPTIONS=(
	--with-icondir="${EPREFIX}"/usr/share/cursors/xorg-x11
	--with-cursorpath='~/.cursors:~/.icons:/usr/local/share/cursors/xorg-x11:/usr/local/share/cursors:/usr/local/share/icons:/usr/local/share/pixmaps:/usr/share/cursors/xorg-x11:/usr/share/cursors:/usr/share/pixmaps/xorg-x11:/usr/share/icons:/usr/share/pixmaps'
)
