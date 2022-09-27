# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-python/eselect-python-20140125.ebuild,v 1.2 2014/02/02 16:32:36 grobian Exp $

# Keep the EAPI low here because everything else depends on it.
# We want to make upgrading simpler.

if [[ ${PV} == "99999999" ]] ; then
	inherit autotools git-r3
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/${PN}.git"
else
	SRC_URI="mirror://gentoo/${P}.tar.bz2
		http://dev.gentoo.org/~floppym/dist/${P}.tar.bz2"
	KEYWORDS="*"
fi

DESCRIPTION="Eselect module for management of multiple Python versions"
HOMEPAGE="http://www.gentoo.org/proj/en/Python/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.3
	!app-admin/eselect-python"

src_unpack() {
	if [[ ${PV} == "99999999" ]] ; then
		git-r3_src_unpack
		cd "${S}"
		eautoreconf
	else
		unpack ${A}
	fi
}

src_install() {
	keepdir /etc/env.d/python
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
	if has_version 'dev-lang/python'; then
		eselect python update --if-unset
	fi
	if has_version '=dev-lang/python-2*'; then
		eselect python update --python2 --if-unset
	fi
	if has_version '=dev-lang/python-3*'; then
		eselect python update --python3 --if-unset
	fi
}
