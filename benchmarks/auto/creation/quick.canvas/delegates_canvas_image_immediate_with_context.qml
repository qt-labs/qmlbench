import QtQuick 2.0

// Testing the performance of creating a canvas with default options, and constantly getting a context.
Item {
    id: root;
    property int count: 50;
    property int staticCount: 2500;

    property real t;
    NumberAnimation on t { from: 0; to: 1; duration: 1000; loops: Animation.Infinite }
    onTChanged: {
        repeater.model = 0;
        repeater.model = root.count
    }

    Component.onCompleted: repeater.model = root.count

    Repeater {
        id: repeater
        Canvas {
            x: Math.random() * (root.width - width)
            y: Math.random() * (root.height - height)
            width: 30
            height: 15
            renderTarget: Canvas.Image
            renderStrategy: Canvas.Immediate

            property real t: root.t
            onTChanged: requestPaint();

            onPaint: {
                var ctx = getContext("2d")
                // no actual rendering here, those are in the canvas-specific
                // tests.
            }
        }
    }
}



