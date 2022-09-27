# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-1.1.0-r1.ebuild,v 1.10 2012/09/08 16:11:17 blueness Exp $

EAPI=4

inherit libtool multilib eutils

DESCRIPTION="The Audio Output library"
HOMEPAGE="http://www.xiph.org/ao/"
SRC_URI="http://downloads.xiph.org/releases/ao/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="alsa nas mmap pulseaudio static-libs"

RDEPEND="alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i -e 's:-O20::' configure || die
	sed -i -e "s:/lib:/$(get_libdir):g" ao.m4 || die
	elibtoolize
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-esd \
		$(use_enable alsa alsa) \
		$(use_enable mmap alsa-mmap) \
		--disable-arts \
		$(use_enable nas) \
		$(use_enable pulseaudio pulse)
}

src_install() {
	emake DESTDIR="${D}" docdir="${EPREFIX}/usr/share/doc/${PF}/html" install
	dodoc AUTHORS CHANGES README TODO
	prune_libtool_files --all
}
