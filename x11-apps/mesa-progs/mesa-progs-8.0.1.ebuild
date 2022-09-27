# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mesa-progs/mesa-progs-8.0.1.ebuild,v 1.8 2011/05/16 07:55:20 mgorny Exp $

EAPI=3

MY_PN=${PN/progs/demos}
MY_P=${MY_PN}-${PV}
EGIT_REPO_URI="git://anongit.freedesktop.org/${MY_PN/-//}"

if [[ ${PV} = 9999* ]]; then
	    GIT_ECLASS="git"
fi

inherit toolchain-funcs ${GIT_ECLASS}

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="http://mesa3d.sourceforge.net/"
if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="ftp://ftp.freedesktop.org/pub/${MY_PN/-//}/${PV}/${MY_P}.tar.bz2"
fi

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	# We're not using the complete buildsystem to avoid dependencies
	# unnecessary for our two little tools.
	:
}

src_compile() {
	tc-export CC
	emake LDLIBS='-lX11 -lGL -lm' src/xdemos/{glxgears,glxinfo} || die
}

src_install() {
	dobin src/xdemos/{glxgears,glxinfo} || die
}
