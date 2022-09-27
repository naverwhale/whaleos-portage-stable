# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )
inherit distutils-r1

DESCRIPTION="Python typed-ast backported"
HOMEPAGE="https://pypi.org/project/typed-ast/ https://github.com/python/typed_ast"
SRC_URI="mirror://pypi/${PN:0:1}/${PN/-/_}/${P/-/_}.tar.gz"
S="${WORKDIR}/${P/-/_}"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="*"

distutils_enable_tests pytest

python_test() {
	cd "${BUILD_DIR}" || die
	epytest
}
