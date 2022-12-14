# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools multilib-minimal

DESCRIPTION="C library that resolves names asynchronously"
HOMEPAGE="https://c-ares.haxx.se/"
SRC_URI="https://${PN}.haxx.se/download/${P}.tar.gz"

# Subslot = SONAME of libcares.so.2
SLOT="0/2"
LICENSE="MIT"
KEYWORDS="*"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

DOCS=( AUTHORS CHANGES NEWS README.md RELEASE-NOTES TODO )

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/ares_build.h
)

multilib_src_configure() {
	# Needed for running unit tests only
	# Violates sandbox and tests pass fine without
	ax_cv_uts_namespace=no \
	ax_cv_user_namespace=no \
	ECONF_SOURCE="${S}" \
	econf \
		--enable-nonblocking \
		--enable-symbol-hiding \
		$(use_enable static-libs static) \
		$(use_enable test tests)
}

multilib_src_test() {
	cd "${BUILD_DIR}"/test || die

	# We're skipping the "real" network tests with the filter
	# see https://github.com/c-ares/c-ares/tree/main/test
	./arestest --gtest_filter=-*Live* || die "arestest failed!"
}

multilib_src_install_all() {
	einstalldocs

	find "${ED}" -name "*.la" -delete || die
}
