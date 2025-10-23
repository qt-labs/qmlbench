import QtQuick
import QtQuick.Shapes
import QmlBench

CreationBenchmark {
    id: root;
    count: 200;
    staticCount: 1000;

    delegate: Shape {
        x: QmlBench.getRandom() * (root.width - width)
        y: QmlBench.getRandom() * (root.height - height)
        width: 100
        height: 100
        preferredRendererType: Shape.CurveRenderer

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
