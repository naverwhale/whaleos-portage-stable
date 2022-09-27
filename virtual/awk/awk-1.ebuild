# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Virtual for awk implementation"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	|| (
		>=sys-apps/gawk-4.0.1-r1
		sys-apps/mawk
		sys-apps/nawk
		sys-apps/busybox
	)"
