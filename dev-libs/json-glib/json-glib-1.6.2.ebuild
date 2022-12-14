# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit gnome.org meson-multilib xdg-utils

DESCRIPTION="Library providing GLib serialization and deserialization for the JSON format"
HOMEPAGE="https://wiki.gnome.org/Projects/JsonGlib"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc +introspection"

RDEPEND="
	>=dev-libs/glib-2.54.0:2[${MULTILIB_USEDEP}]
	introspection? ( >=dev-libs/gobject-introspection-0.9.5:= )
"
DEPEND="${RDEPEND}"
# TODO: Can we use a newer docbook-xml-dtd, or is one needed at all?
BDEPEND="
	~app-text/docbook-xml-dtd-4.1.2
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	dev-util/glib-utils
	gtk-doc? ( >=dev-util/gtk-doc-1.20 )
	>=sys-devel/gettext-0.18
	virtual/pkgconfig
"

src_prepare() {
	xdg_environment_reset
	default
	# Disable installed-tests; this also indirectly removes build_aux/gen-installed-test.py calls, thus not needing python-any-r1.eclass
	sed -e 's/install: true/install: false/g' -i json-glib/tests/meson.build || die
	sed -e '/install_data/d' -i json-glib/tests/meson.build || die
}

multilib_src_configure() {
	local emesonargs=(
		$(meson_native_use_feature introspection)
		$(meson_native_use_feature gtk-doc gtk_doc)
		$(meson_native_true man)
	)
	meson_src_configure
}
