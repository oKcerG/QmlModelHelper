QmlModelHelper
==============

Access your models from QML without views or delegates

Installation
------------
1. clone or download this repository
2. add `include  (<path/to/QmlModelHelper>/QmlModelHelper.pri)` in your `.pro`
3. `import ModelHelper 0.1` to use this library in your QML files

Motivation
----------
Sometimes you want to query some model data while not being in a view. You can do so with the `Q_INVOKABLE` methods of `QAbstractItemModels` but those returns static result that won't change when the model gets updated.
By listening on the `QAbstractItemModel` signals, this library can expose proper properties with notify signals for easy binding in declarative QML code.

Documentation
------------

To use the `ModelHelper`, use it as an attached object of a model (it must be a subclass of `QAbstractItemModel`, meaning it can originate from c++ or be a `ListModel` from QML).

### Attached properties:
##### rowCount : int
This property holds the number of rows in the model.

##### count : int
This property holds the number of rows in the model. Alias for `rowCount`.

##### columnCount : int
This property holds the number of columns in the model.

##### roles : array
This property holds an array of objects describing the roles of the model. Each object has 2 properties: `role`, the number of the role; and `roleName`, the name of the role.

### Attached methods:
##### object map(int row, int column = 0, QModelIndex parent = {})
Returns a live object mapping an index's data of the model. This is an object with read-write properties named as the model's roles.
If the index doesn't exist in the model, the properties will be `undefined`.

Example: (source problematic from https://stackoverflow.com/questions/41591544/qt-accessing-model-data-outside-itemdelegate/ )
```
ComboBox {
    id: control
    model: vehiclesModel
    readonly property QtObject currentData: vehiclesModel.ModelHelper.map(control.currentIndex)
    contentItem: RowLayout {
        id: contentItem
        Image { source: control.currentData.imagePath }
        Label { text: control.currentData.name }
    }
    delegate: ItemDelegate {
        contentItem: RowLayout {
            Image { source: model.imagePath }
            Label { text: model.name }
        }
        highlighted: control.highlightedIndex == index
    }
}
```
This is can be used with the same goal in mind than a [`QDataWidgetMapper`](https://doc.qt.io/qt-5/qdatawidgetmapper.html).

##### int roleForName(string roleName)
Returns the role number for the given `roleName`. If no role is found for this name, `-1` is returned.

##### var data(int row)
Return the item at `row` in the model as a map of all its roles.

This can be used in imperative code when you don't need the live updating provided by the `map` function. Only reading is supported.

##### var data(int row, string roleName)
Return the data for the given `roleName` of the item at `row` in the model.

Similar to `data(int row)` except that it queries only one role. Prefer this one if you don't need multiple roles for a row.

License
-------
This library is licensed under the MIT License.
