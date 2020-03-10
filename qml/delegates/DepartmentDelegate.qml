import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14
import QtQuick.Controls.Material 2.14

import "qrc:/qml"

XSwipeDelegate {
    id: deparmentDelegate
    width: departmentListView.width

    text: name
    secondaryText: description

    swipe.right: deleteComponent
    swipe.onCompleted: {
        viewModel.deleteDepartment(guid, index)
    }
    Component {
        id: deleteComponent

        Rectangle {
            id: editContainer
            width: parent.width
            height: parent.height
            color: Material.color(Material.Red)
            visible: swipe.position !== 0

            IconLabel {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
                icon.source: "qrc:/img/icons/delete.svg"
                icon.width: 32
                icon.height: 32
                icon.color: "#FFFFFF"
            }
        }
    }

    ListView.onRemove: SequentialAnimation {
        PropertyAction {
            target: deparmentDelegate
            property: "ListView.delayRemove"
            value: true
        }
        NumberAnimation {
            target: deparmentDelegate
            property: "height"
            to: 0
            easing.type: Easing.InOutQuad
        }
        PropertyAction {
            target: deparmentDelegate
            property: "ListView.delayRemove"
            value: false
        }
    }

    onClicked: departmentNavController.gotoView(departmentNavController.departmentDetailsViewIndex, guid)
}
