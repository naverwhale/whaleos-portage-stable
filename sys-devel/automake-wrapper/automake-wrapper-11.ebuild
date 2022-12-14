# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="wrapper for automake to manage multiple automake versions"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

S=${WORKDIR}

src_unpack() {
	cp "${FILESDIR}"/am-wrapper-${PV}.sh "${S}"/ || die
}

src_prepare() {
	default

	# usr/bin/aclocal: bad substitution -> /bin/sh != POSIX shell
	if use prefix ; then
		sed -i -e '1c\#!'"${EPREFIX}"'/bin/sh' \
			"${S}"/am-wrapper-${PV}.sh || die
	fi
}

src_install() {
	newbin "${S}"/am-wrapper-${PV}.sh automake
	dosym automake /usr/bin/aclocal

	keepdir /usr/share/aclocal
}
