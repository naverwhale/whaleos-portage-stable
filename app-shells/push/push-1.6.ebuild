# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/push/push-1.6.ebuild,v 1.12 2014/08/10 18:22:49 slyfox Exp $

EAPI="4"
inherit vcs-snapshot

DESCRIPTION="A POSIX shell function to treat a variable like an array, quoting args"
HOMEPAGE="https://github.com/vaeth/push/"
SRC_URI="http://github.com/vaeth/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

src_install() {
	insinto /usr/bin
	doins push.sh
	dodoc README
}
