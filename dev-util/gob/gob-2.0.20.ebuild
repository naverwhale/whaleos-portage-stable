# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"
GNOME_ORG_MODULE="gob2"

inherit gnome2

DESCRIPTION="Preprocessor for making GTK+ objects with inline C code"
HOMEPAGE="http://www.jirka.org/gob.html"

LICENSE="GPL-2+"
SLOT="2"
KEYWORDS="*"
IUSE=""

RDEPEND=">=dev-libs/glib-2.4:2"
DEPEND="${RDEPEND}
	sys-devel/flex
	virtual/pkgconfig
	virtual/yacc
"
