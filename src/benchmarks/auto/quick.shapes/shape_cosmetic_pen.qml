import QtQuick
import QtQuick.Shapes
import QmlBench

Benchmark {
    id: root;

    count: 500
    staticCount: 2000

    Repeater {
        model: root.count
        Shape {
            x: QmlBench.getRandom() * (root.width - width)
            y: QmlBench.getRandom() * (root.height - height)
            width: 200
            height: 200
            scale: 2
            transformOrigin: Item.TopLeft
            preferredRendererType: Shape.GeometryRenderer

            ShapePath {
                fillColor: "red"
                strokeColor: "green"
                strokeWidth: 2
                cosmeticStroke: true

                PathSvg {
                    path: "M10,35 A20,20,0,0,1,50,35 A20,20,0,0,1,90,35 Q90,65,50,95 Q10,65,10,35 Z"
                }
            }
        }
    }
}
