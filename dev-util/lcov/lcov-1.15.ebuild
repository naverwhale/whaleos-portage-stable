# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/linux-test-project/lcov.git"
	inherit git-r3
else
	SRC_URI="https://github.com/linux-test-project/lcov/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="*"
fi

inherit optfeature prefix

DESCRIPTION="A graphical front-end for GCC's coverage testing tool gcov"
HOMEPAGE="http://ltp.sourceforge.net/coverage/lcov.php"

LICENSE="GPL-2+"
SLOT="0"

RDEPEND="
	dev-lang/perl
	dev-perl/JSON
	dev-perl/PerlIO-gzip
"

src_prepare() {
	default
	if use prefix; then
		hprefixify bin/*.{pl,sh}
	fi
}

src_compile() { :; }

src_install() {
	emake -j1 PREFIX="${ED}/usr" CFG_DIR="${ED}/etc" install
}

pkg_postinst() {
	elog "Optional features:"
	optfeature "png output support" dev-perl/GD[png]
}
