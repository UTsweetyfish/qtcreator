// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only WITH Qt-GPL-exception-1.0

import QtQuick
import QtQuickDesignerTheme 1.0
import HelperWidgets 2.0
import StudioTheme 1.0 as StudioTheme

PropertyEditorPane {
    id: root

    width: 420
    height: 420

    signal toolBarAction(int action)
    signal previewEnvChanged(string env)
    signal previewModelChanged(string model)

    // Called from C++, dummy methods to avoid warnings
    function closeContextMenu() {}
    function initPreviewData(env, model) {}

    Column {
        id: col

        MaterialEditorToolBar {
            width: root.width

            onToolBarAction: (action) => root.toolBarAction(action)
        }

        Item {
            width: root.width - 2 * col.padding
            height: 150

            Text {
                text: {
                    if (!isQt6Project)
                        qsTr("<b>Material Editor</b> is not supported in Qt5 projects.")
                    else if (!hasQuick3DImport)
                        qsTr("To use <b>Material Editor</b>, first add the QtQuick3D module in the <b>Components</b> view.")
                    else if (!hasMaterialLibrary)
                        qsTr("<b>Material Editor</b> is disabled inside a non-visual component.")
                    else
                        qsTr("There are no materials in this project.<br>Select '<b>+</b>' to create one.")
                }
                textFormat: Text.RichText
                color: StudioTheme.Values.themeTextColor
                font.pixelSize: StudioTheme.Values.mediumFontSize
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                width: root.width
                anchors.centerIn: parent
            }
        }
    }
}
