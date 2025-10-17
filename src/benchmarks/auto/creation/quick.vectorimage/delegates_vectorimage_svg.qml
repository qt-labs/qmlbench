import QtQuick
import QtQuick.VectorImage
import QmlBench

CreationBenchmark {
    id: root;
    count: 1;
    staticCount: 1;

    delegate: VectorImage {
        x: QmlBench.getRandom() * (root.width - width)
        y: QmlBench.getRandom() * (root.height - height)
        width: 100
        height: 100
        preferredRendererType: VectorImage.CurveRenderer
        animations.loops: Animation.Infinite

        source: "qrc:///shared/css_animate_props_multiple_values.svg"
    }
}
