/*
    DigitalJoystick, a visual Joystick for Qt QML that supports multiple joysticks on touch screens.
    Copyright (C) 2023  JDavid "Blackhack" <davidaristi.0504@gmail.com>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
    USA
 */

import QtQuick

Rectangle {
    property double radius_guide

    width: radius_guide*2
    height: radius_guide*2
    color: "steelblue"
    border.color: "black"
    border.width: 3
    radius: radius_guide
}
