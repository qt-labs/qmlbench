import QtQuick
import QtQuick.Shapes
import QmlBench

CreationBenchmark {
    id: root;
    count: 50;
    staticCount: 250;

    RadialGradient {
        id: radialGradient
        centerX: 50; centerY: 50
        centerRadius: 50
        focalX: centerX; focalY: centerY
        GradientStop { position: 0; color: "blue" }
        GradientStop { position: 0.2; color: "green" }
        GradientStop { position: 0.4; color: "red" }
        GradientStop { position: 0.6; color: "yellow" }
        GradientStop { position: 1; color: "cyan" }
    }

    delegate: Shape {
        x: QmlBench.getRandom() * (root.width - width)
        y: QmlBench.getRandom() * (root.height - height)
        width: 100
        height: 100
        preferredRendererType: Shape.GeometryRenderer

        ShapePath {
            fillGradient: radialGradient
            strokeColor: "transparent"

            PathSvg {
                path: "M10,35 A20,20,0,0,1,50,35 A20,20,0,0,1,90,35 Q90,65,50,95 Q10,65,10,35 Z"
            }
        }
    }
}
