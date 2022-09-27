# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
PYTHON_REQ_USE="ncurses(+)"

inherit distutils-r1 linux-info

DESCRIPTION="Top-like UI used to show which process is using the I/O"
HOMEPAGE="http://guichaz.free.fr/iotop/"
SRC_URI="http://guichaz.free.fr/iotop/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

CONFIG_CHECK="~TASK_IO_ACCOUNTING ~TASK_DELAY_ACCT ~TASKSTATS ~VM_EVENT_COUNTERS"

DOCS=( NEWS README THANKS ChangeLog )

PATCHES=(
	"${FILESDIR}"/${P}-setup.py3.patch
	"${FILESDIR}"/${P}-Only-split-proc-status-lines-on-the-character.patch
	"${FILESDIR}"/${P}-Ignore-invalid-lines-in-proc-status-files.patch
	"${FILESDIR}"/${P}-Actually-skip-invalid-lines-in-proc-status.patch
)

pkg_setup() {
	linux-info_pkg_setup
}
