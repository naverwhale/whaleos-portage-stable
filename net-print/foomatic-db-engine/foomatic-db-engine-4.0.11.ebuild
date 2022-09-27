# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GENTOO_DEPEND_ON_PERL_SUBSLOT=yes
inherit eutils perl-app versionator autotools

DESCRIPTION="Generates ppds out of xml foomatic printer description files"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://www.openprinting.org/download/foomatic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="net-print/cups"
DEPEND="net-print/cups
	virtual/pkgconfig"

RDEPEND="
	dev-libs/libxml2
	|| ( >=net-print/cups-filters-1.0.43-r1[foomatic] net-print/foomatic-filters )
"
PDEPEND="net-print/foomatic-db"

src_prepare() {
	epatch \
		"${FILESDIR}"/4.0.7-perl-module.patch \
		"${FILESDIR}"/4.0.7-respect-ldflag.patch \
		"${FILESDIR}"/4.0.12-use-pkgconfig.patch
	sed -i -e "s:@LIB_CUPS@:$(cups-config --serverbin):" Makefile.in || die
	eautoreconf
}

src_configure() {
	default
	emake defaults

	cd lib
	perl-app_src_configure
}

src_compile() {
	emake

	cd lib
	perl-app_src_compile
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README TODO USAGE

	cd lib
	perl-module_src_install
}

src_test() {
	cd lib
	perl-module_src_test
}
