import QtQuick
import QtQuick.VectorImage
import QmlBench

CreationBenchmark {
    id: root;
    count: 10;
    staticCount: 10;

    delegate: VectorImage {
        x: QmlBench.getRandom() * (root.width - width)
        y: QmlBench.getRandom() * (root.height - height)
        width: 100
        height: 100
        preferredRendererType: VectorImage.CurveRenderer
        animations.loops: Animation.Infinite
        assumeTrustedSource: true

        source: "qrc:///shared/bouncy_ball.json"
    }
}
