/****************************************************************************
**
** Copyright (C) 2017 Crimson AS <info@crimson.no>
** Contact: https://www.qt.io/licensing/
**
** This file is part of the qmlbench tool.
**
** $QT_BEGIN_LICENSE:GPL-EXCEPT$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0

Item {
    id: root
    width: 320
    height: 480

    Component.onCompleted: {
        var object
        if (benchmark.count != -1) {
            object = benchmark.component.createObject(benchmarkRoot, { count: benchmark.count });
        } else {
            object = benchmark.component.createObject(benchmarkRoot);
            if (!object.hasOwnProperty("count")) {
                print(" - error: property 'count' is lacking from: " + benchmark.input);
                benchmark.abort();
            }

            if (object.hasOwnProperty("staticCount")) {
                object.count = object.staticCount * benchmark.hardwareMultiplier
            }
        }
        object.anchors.fill = benchmarkRoot;
        root.targetFrameRate = benchmark.screenRefreshRate;
        root.item = object;
        label.updateYerself()
    }

    property Item item;
    property real targetFrameRate;
    property real fps: 0

    Item {
        id: benchmarkRoot
        clip: true
        anchors.fill: parent
    }

    Rectangle {
        id: meter

        clip: true
        width: root.width
        height: 14
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        color: Qt.hsla(0, 0, 1, 0.8);

        Rectangle {
            id: swapTest
            anchors.right: parent.right
            width: parent.height
            height: parent.height
            property real t;
            NumberAnimation on t { from: 0; to: 1; duration: 1000; loops: Animation.Infinite }
            property bool inv;
            onTChanged: {
                ++fpsTimer.tick;
                inv = !inv;
            }
            color: inv ? "red" : "blue"
        }

        Timer {
            id: fpsTimer
            running: true;
            repeat: true
            interval: benchmark.fpsInterval
            property var lastFrameTime: new Date();
            property int tick;

            onTriggered: {
                var now = new Date();
                var dt = now.getTime() - lastFrameTime.getTime();
                lastFrameTime = now;
                var fps = (tick * 1000) / dt;
                root.fps = Math.round(fps * 10) / 10;
                tick = 0;

                label.updateYerself();
            }
        }

        Text {
            id: label
            anchors.centerIn: parent
            font.pixelSize: 10

            function updateYerself() {
                var bmName = benchmark.input;
                var lastSlash = bmName.lastIndexOf("/");
                if (lastSlash > 0)
                    bmName = bmName.substr(lastSlash + 1);
                text = bmName + "; FPS=" + root.fps + "; Count=" + item.count;
            }
        }


    }

}
