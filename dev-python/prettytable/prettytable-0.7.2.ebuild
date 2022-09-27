# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Easily displaying tabular data in a visually appealing ASCII table format"
HOMEPAGE="https://code.google.com/p/prettytable/"
SRC_URI="mirror://pypi/P/PrettyTable/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

python_test() {
	"${PYTHON}" prettytable_test.py || die "tests failed under ${EPYTHON}"
}
