# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://gitlab.freedesktop.org/pixman/pixman.git"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
fi

inherit ${GIT_ECLASS} meson-multilib multiprocessing toolchain-funcs

DESCRIPTION="Low-level pixel manipulation routines"
HOMEPAGE="http://www.pixman.org/ https://gitlab.freedesktop.org/pixman/pixman/"
if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
else
	KEYWORDS="*"
	SRC_URI="https://www.x.org/releases/individual/lib/${P}.tar.xz"
fi

LICENSE="MIT"
SLOT="0"
IUSE="cpu_flags_ppc_altivec cpu_flags_arm_iwmmxt cpu_flags_arm_iwmmxt2 cpu_flags_arm_neon loongson2f cpu_flags_x86_mmxext cpu_flags_x86_sse2 cpu_flags_x86_ssse3 static-libs"

multilib_src_configure() {
	local openmp=disabled
	tc-has-openmp && openmp=enabled

	local emesonargs=(
		$(meson_feature cpu_flags_arm_iwmmxt iwmmxt)
		$(meson_use     cpu_flags_arm_iwmmxt2 iwmmxt2)
		$(meson_feature cpu_flags_x86_mmxext mmx)
		$(meson_feature cpu_flags_x86_sse2 sse2)
		$(meson_feature cpu_flags_x86_ssse3 ssse3)
		$(meson_feature cpu_flags_ppc_altivec vmx)
		$(meson_feature cpu_flags_arm_neon neon)
		$(meson_feature loongson2f loongson-mmi)
		-Ddefault_library=$(usex static-libs both shared)
		-Dgtk=disabled
		-Dlibpng=disabled
		-Dopenmp=$openmp # only used in unit tests
	)
	meson_src_configure
}

multilib_src_test() {
	export OMP_NUM_THREADS=$(makeopts_jobs)
	meson_src_test -t 100
}
