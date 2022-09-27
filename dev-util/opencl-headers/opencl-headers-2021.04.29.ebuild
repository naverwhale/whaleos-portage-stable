# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="OpenCL-Headers"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Unified C language headers for the OpenCL API"
HOMEPAGE="https://github.com/KhronosGroup/OpenCL-Headers"
SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"

# CHROMIUM: We stopped installing the CL headers from our custom ebuild.
RDEPEND="!<=x11-drivers/opengles-headers-0.0.1-r36"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/include
	doins -r "${S}"/CL
}
