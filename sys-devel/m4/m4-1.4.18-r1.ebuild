# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="GNU macro processor"
HOMEPAGE="https://www.gnu.org/software/m4/m4.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="examples"

# remember: cannot dep on autoconf since it needs us
DEPEND="app-arch/xz-utils"
RDEPEND=""

src_prepare() {
	eapply "${FILESDIR}"/${P}-darwin17-printf-n.patch
	eapply "${FILESDIR}"/${P}-glibc228.patch #663924
	default
}

src_configure() {
	# Disable automagic dependency over libsigsegv; see bug #278026
	export ac_cv_libsigsegv=no

	local myconf=""
	[[ ${USERLAND} != "GNU" ]] && myconf="--program-prefix=g"
	econf --enable-changeword ${myconf}
}

src_test() {
	[[ -d /none ]] && die "m4 tests will fail with /none/" #244396
	emake check
}

src_install() {
	default
	# autoconf-2.60 for instance, first checks gm4, then m4.  If we don't have
	# gm4, it might find gm4 from outside the prefix on for instance Darwin
	use prefix && dosym m4 /usr/bin/gm4
	if use examples ; then
		docinto examples
		dodoc -r examples/
		rm -f "${ED}"/usr/share/doc/${PF}/examples/Makefile*
	fi
}
