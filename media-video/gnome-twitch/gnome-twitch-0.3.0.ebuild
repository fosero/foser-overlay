# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils gnome2

DESCRIPTION="Enjoy Twitch on your GNU/Linux desktop"
HOMEPAGE="http://gnome-twitch.vinszent.com/"

SRC_URI="https://github.com/vinszent/${PN}/archive/v${PV}.tar.gz"

LICENSE=""
SLOT="0"

IUSE=""
# TODO: enable/disable plugins
#IUSE="gstreamer clutter cairo opengl"
#REQUIRED_USE="gstreamer? ( || ( clutter cairo opengl ) )"

KEYWORDS="~amd64"


RDEPEND="
	>=x11-libs/gtk+-3.20
	net-libs/libsoup:2.4
	dev-libs/json-glib
	dev-libs/libpeas[gtk]

	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0

	net-libs/webkit-gtk:4
"
DEPEND="${RDEPEND}
	>=dev-util/meson-0.32
	dev-util/ninja
"

src_prepare() {

	eapply ${FILESDIR}/${P}-fix_builddir.patch

	eapply_user

}

src_configure() {

	mkdir ${S}/build
	cd ${S}/build

	# post install steps done by gnome2 eclass
	meson \
		--prefix /usr \
		--libdir lib \
		-Dwith-player-gstreamer-opengl=true \
		-Dwith-player-gstreamer-clutter=true \
		-Dwith-player-gstreamer-cairo=true \
		-Ddo-post-install=false \
		-Db_lundef=false \
		..

}

src_compile() {

	cd ${S}/build
	ninja || die

}

src_install() {

	cd ${S}/build
	DESTDIR=${D} ninja install || die

}
