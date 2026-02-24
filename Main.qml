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

	property var sizes: [
		{size: 1, enabled: false},
		{size: 10, enabled: false},
		{size: 100, enabled: false},
		{size: 1000, enabled: false},
		{size: 10000, enabled: false}
	]

	property var distances: [
		{distance: 1, enabled: false},
		{distance: 10, enabled: false},
		{distance: 100, enabled: false},
		{distance: 1000, enabled: false},
		{distance: 10000, enabled: false}
	]

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

		let txt = "sizes:"
		sizes.forEach(s => {
			txt += `\nsize: ${s.size}, on: ${s.enabled}`
		})
		txt += "\ndistances:"
		distances.forEach(d => {
			txt += `\ndist: ${d.distance}, on: ${d.enabled}`
		})

		clickPos.text = txt
	}

	function sizeToggle(size) {
		console.log(`sizeToggle: ${size}`)

		//todo: не лучший вариант (?)
		sizes.forEach(s =>{
			if (s.size === size) {
				s.enabled = !s.enabled
			}
		})
	}
	function distanceToggle(distance) {
		console.log(`distanceToggle: ${distance}`)

		//todo: не лучший вариант (?)
		distances.forEach(d =>{
			if (d.distance === distance) {
				d.enabled = !d.enabled
			}
		})
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
			title: qsTr("Настройки")

			Menu {
				title: qsTr("Размеры")

				Action {
					property int size: 1
					text: this.size
					checkable: true
					onCheckedChanged: sizeToggle(this.size)
				}

				Action {
					text: qsTr("test2")
					checkable: true
				}
			}

			Menu {
				title: qsTr("Расстояния")

				Action {
					property int distance: 1
					text: this.distance
					checkable: true
					onCheckedChanged: distanceToggle(this.distance)
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
