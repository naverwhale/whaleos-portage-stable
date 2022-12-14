# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=NWCLARK
DIST_VERSION=0.20
inherit perl-module

DESCRIPTION="PerlIO layer to gzip/gunzip"

SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
