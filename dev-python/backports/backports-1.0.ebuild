# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} pypy{,3} )

inherit distutils-r1

DESCRIPTION="Namespace for backported Python features"
HOMEPAGE="https://bitbucket.org/brandon/backports https://pypi.org/project/backports/"
SRC_URI="https://dev.gentoo.org/~radhermit/dist/${P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="*"

RDEPEND="!<dev-python/backports-lzma-0.0.2-r1"
