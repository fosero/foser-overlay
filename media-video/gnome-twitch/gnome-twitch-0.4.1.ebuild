# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2 meson

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
	>=x11-libs/gtk+-3.22
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
	>=dev-util/meson-0.36
	dev-util/ninja
"

src_configure() {

	local emesonargs=(
		-Dbuild-player-backends=gstreamer-cairo,gstreamer-opengl,gstreamer-clutter
		-Ddo-post-install=false
		-Db_lundef=false
	)

	meson_src_configure

}
