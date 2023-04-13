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

MultiPointTouchArea {
    id: root

    property string name: "joystick"
    property int update_interval: 50
    property double handle_scale: 70.0
    property double last_x_pct: 0.0
    property double last_y_pct: 0.0
    signal joystickUpdated(double x_pct, double y_pct);

    Item {
        id: rootCenter
        anchors.centerIn: root
    }

    Timer {
        id: reportingTimer
        interval: update_interval; running: true; repeat: true
        onTriggered: joystickUpdated(last_x_pct, last_y_pct)
    }

    Guide {
        id: guide

        radius_guide: root.width/2
        x: rootCenter.x-(width/2)
        y: rootCenter.y-(height/2)
    }

    Handle {
        id: handle

        radius_handle: root.width/2*(handle_scale/100)
        x: rootCenter.x-(width/2)
        y: rootCenter.y-(height/2)
    }

    function updateHandlePosition(point_x, point_y)
    {
        // point_x and poiny_y are originated from the square corner
        // so to simplified math, I just made an axis translation
        // putting it at the center of the square
        // x = x' + k
        // y = y' + h
        var k = rootCenter.y
        var h = rootCenter.x
        var centered_x = point_x - k
        var centered_y = point_y - h

        var theta = Math.atan2(centered_y, centered_x)
        var current_radius = (centered_y) / Math.sin(theta)

        if (current_radius > guide.radius_guide)
        {
            // Force radius to be inside the guide and translate axis to its original position
            point_x = guide.radius*Math.cos(theta) + k
            point_y = guide.radius*Math.sin(theta) + h
        }

        // Update the handle position
        // Center point on handle (not neccesary the square center)
        handle.x = point_x - (handle.width/2)
        handle.y = point_y - (handle.height/2)

        // Calculating position pct of each axis (again using the square center as the origin)
        var x_pct = (point_x - k)/guide.radius_guide
        var y_pct = (point_y - h)/guide.radius_guide

        // Invert Y axis, so is more like the "standard" where Y is positive up (in qt Y is negative down)
        last_x_pct = x_pct.toFixed(3)
        last_y_pct = -y_pct.toFixed(3)
    }

    onTouchUpdated: function(points){
        if (points.length > 0)
            updateHandlePosition(points[0].x, points[0].y)
        else
            updateHandlePosition(rootCenter.x, rootCenter.y)
    }
}
