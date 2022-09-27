# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

KEYWORDS="*"
MY_P="${PN}-v${PV}"
SRC_URI="https://gitlab.freedesktop.org/slirp/libslirp/-/archive/v${PV}/${MY_P}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="A general purpose TCP-IP emulator used by virtual machine hypervisors to provide virtual networking services."
HOMEPAGE="https://gitlab.freedesktop.org/slirp/libslirp"

LICENSE="BSD"
SLOT="0"
IUSE="static-libs"

RDEPEND="dev-libs/glib:="

DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}/libslirp-4.3.1-bug-756910-check-pkt_len.patch"
)

src_prepare() {
	default
	echo "${PV}" > .tarball-version || die
	echo -e "#!${BASH}\necho -n \$(cat '${S}/.tarball-version')" > build-aux/git-version-gen || die
}

src_configure() {
	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
	)
	meson_src_configure
}
