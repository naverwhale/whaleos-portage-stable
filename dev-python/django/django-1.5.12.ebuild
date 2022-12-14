# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 pypy python3_{6,7} )
PYTHON_REQ_USE='sqlite?,threads(+)'
WEBAPP_NO_AUTO_INSTALL="yes"

inherit bash-completion-r1 distutils-r1 versionator webapp

MY_P="Django-${PV}"

DESCRIPTION="High-level Python web framework"
HOMEPAGE="https://www.djangoproject.com/ https://pypi.org/project/Django/"
SRC_URI="https://www.djangoproject.com/m/releases/$(get_version_component_range 1-2)/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="doc mysql postgres sqlite test"

RDEPEND="( $(python_gen_cond_dep 'dev-python/imaging[${PYTHON_USEDEP}]' 'python2*' ) )
	( $(python_gen_cond_dep 'dev-python/pillow[${PYTHON_USEDEP}]' 'python3*' ) )
	postgres? ( $(python_gen_cond_dep 'dev-python/psycopg:2[${PYTHON_USEDEP}]' 'python*') )
	mysql? ( $(python_gen_cond_dep '>=dev-python/mysql-python-1.2.3[${PYTHON_USEDEP}]' 'python*') )"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-1.0.7[${PYTHON_USEDEP}] )
	test? ( $(python_gen_impl_dep sqlite) )"

REQUIRED_USE="mysql? ( $(python_gen_useflags 'python2*') )
		postgres? ( || ( $(python_gen_useflags 'python2*') ) )"

S="${WORKDIR}/${MY_P}"

WEBAPP_MANUAL_SLOT="yes"

PATCHES=( "${FILESDIR}"/${PN}-1.5.4-objects.patch \
		"${FILESDIR}"/${PN}-1.5-py3tests.patch \
		"${FILESDIR}"/${PN}-1.5-py35.patch )

python_compile_all() {
	if use doc; then
		emake -C docs html
	fi
}

python_test() {
	# Tests have non-standard assumptions about PYTHONPATH,
	# and don't work with ${BUILD_DIR}/lib.
	# https://code.djangoproject.com/ticket/20514
	PYTHONPATH=. "${PYTHON}" tests/runtests.py --settings=test_sqlite -v1 \
		|| die "Tests fail with ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install
	webapp_src_install
}

python_install_all() {
	newbashcomp extras/django_bash_completion ${PN}

	if use doc; then
		rm -fr docs/_build/html/_sources
		local HTML_DOCS=( docs/_build/html/. )
	fi

	insinto "${MY_HTDOCSDIR#${EPREFIX}}"
	doins -r django/contrib/admin/static/admin/.
	distutils-r1_python_install_all
}

pkg_postinst() {
	elog "A copy of the admin media is available to webapp-config for installation in a"
	elog "webroot, as well as the traditional location in python's site-packages dir"
	elog "for easy development."
	webapp_pkg_postinst
}
