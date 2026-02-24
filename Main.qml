import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
	width: 640
	height: 480
	visible: true
	color: "grey"
	title: qsTr("Лабораторная работа №1")

	property bool mouseFlag

	property var moveBegin
	property var moveDuration


	MouseArea {
		id: mainMouseArea
		width: parent.width
		height: parent.height

		hoverEnabled: true
		onPositionChanged: moveFlagToggle(true)
	}

	function moveFlagToggle(flag) {
		console.log('moveFlaToggle ', flag)
		mouseFlag = flag
		if (flag) {
			moveDuration = Timer.start
		} else {
			moveDuration = Timer.stop
		}

		clickPos.text = `dur: ${moveDuration}`
	}

	Rectangle {
		id: rect
		color: "white"

		height: 100
		width: 4 * height

		x: parent.width / 2 - this.width / 2
		y: parent.height / 2 - this.height / 2

		MouseArea {
			width: parent.width
			height: parent.height

			onClicked: () => {
				moveRect()
				moveFlagToggle(false)
			}
		}
	}

	Text {
		id: clickPos
		x: 32
		y: 32
	}

	function moveRect() {
		rect.x = Math.random() * (this.width - rect.width)
		rect.y = Math.random() * (this.height - rect.height)
	}

	MenuBar {
		width: parent.width

		MenuBarItem {
			text: qsTr("Сброс")
		}

		Menu {
			title: qsTr("Sample text")

			Menu {
				title: qsTr("Sample text0")

				Action {
					text: qsTr("test1")
					checkable: true
				}

				Action {
					text: qsTr("test2")
					checkable: true
				}
			}

			Menu {
				title: qsTr("Sample text1")

				Action {
					text: qsTr("test3")
					checkable: true
				}

				Action {
					text: qsTr("test4")
					checkable: true
				}
			}
		}

		MenuBarItem {
			text: qsTr("Выйти")
			onClicked: close()
		}
	}
}
