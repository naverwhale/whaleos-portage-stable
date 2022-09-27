# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Virtual to select between different tmpfiles.d handlers"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	|| (
		sys-apps/opentmpfiles
		sys-apps/systemd
		sys-apps/systemd-tmpfiles
	)"
