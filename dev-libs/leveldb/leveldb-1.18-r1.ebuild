# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/leveldb/leveldb-1.18-r1.ebuild,v 1.1 2015/03/06 09:12:42 vapier Exp $

EAPI=5

inherit eutils multilib toolchain-funcs versionator

DESCRIPTION="a fast key-value storage library written at Google"
HOMEPAGE="http://leveldb.org/ https://github.com/google/leveldb"
SRC_URI="https://github.com/google/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="+snappy static-libs +tcmalloc"

DEPEND="tcmalloc? ( dev-util/google-perftools )
	snappy? (
		app-arch/snappy
		static-libs? ( app-arch/snappy[static-libs] )
	)"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.18-mips.patch
	epatch "${FILESDIR}"/${PN}-1.18-configure.patch #541186

	local SHARED_MINOR=$(get_version_component_range 2)
	sed \
		-e "s/\(^ SHARED_MINOR =\).*/\1 ${SHARED_MINOR}/" \
		"${FILESDIR}/${PN}-1.9.0-memenv-so.patch" > memenv-so.patch
	epatch memenv-so.patch
}

src_configure() {
	# These vars all get picked up by build_detect_platform
	# which the Makefile runs for us automatically.
	tc-export AR CC CXX
	export OPT="-DNDEBUG ${CPPFLAGS}"

	TARGET_OS="Linux" \
	USE_SNAPPY=$(usex snappy) \
	USE_TCMALLOC=no \
	TMPDIR=${T} \
	sh -x ./build_detect_platform build_config.mk ./
}

src_compile() {
	emake $(usex static-libs 'libmemenv.a' 'LIBRARY=') all libmemenv.SHARED
}

src_test() {
	emake check
}

src_install() {
	insinto /usr/include
	doins -r include/*
	# This matches the path Debian picked.  Upstream provides no guidance.
	insinto /usr/include/leveldb/helpers
	doins helpers/memenv/memenv.h

	dolib.so libleveldb*$(get_libname)*
	use static-libs && dolib.a libleveldb.a libmemenv.a
	dolib.so libmemenv*$(get_libname)*
}