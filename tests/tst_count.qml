import QtQuick 2.0
import QtQml 2.2
import QtTest 1.1
import ModelHelper 0.1

Item {
    ListModel {
        id: testModel
        ListElement{foo: 1}
        ListElement{foo: 1}
        ListElement{foo: 1}
        ListElement{foo: 1}
    }
    TestCase {
        name: "CountTest"
        function test_rowCount() {
            var helper = testModel.ModelHelper;
            compare(helper.count, 4);
            compare(helper.rowCount, 4);
            compare(helper.columnCount, 1);

            testModel.clear();
            compare(helper.count, 0);

            testModel.append({"foo": 2});
            testModel.append({"foo": 2});
            compare(helper.count, 2);

            testModel.remove(0);
            compare(helper.count, 1);
        }
    }
}
