# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit multilib-minimal libtool

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="https://github.com/rpm-software-management/popt"
SRC_URI="http://ftp.rpm.org/${PN}/releases/${PN}-1.x/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="nls static-libs"

RDEPEND="nls? ( >=virtual/libintl-0-r1[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"
BDEPEND="nls? ( sys-devel/gettext )"

src_prepare() {
	default
	sed -i -e 's:lt-test1:test1:' tests/testit.sh || die
	elibtoolize
}

multilib_src_configure() {
	local myeconfargs=(
		$(use_enable static-libs static)
		$(use_enable nls)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_install_all() {
	dodoc CHANGES README
	find "${ED}" -type f -name "*.la" -delete || die
}
