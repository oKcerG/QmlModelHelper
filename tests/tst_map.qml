import QtQuick 2.0
import QtQml 2.2
import QtTest 1.1
import ModelHelper 0.1

Item {
    ListModel {
        id: testModel
        ListElement{foo: 0; bar: "a"}
        ListElement{foo: 1; bar: "b"}
        ListElement{foo: 2; bar: "c"}
    }
    TestCase {
        name: "CountTest"
        function test_map() {
            var helper = testModel.ModelHelper;
            var map0 = helper.map(0);
            var map1 = helper.map(1);
            var map2 = helper.map(2);
            var map3 = helper.map(3);

            compare(map0.foo, 0);
            compare(map0.bar, "a");
            compare(map1.foo, 1);
            compare(map2.foo, 2);
            compare(map3.foo, undefined);

            testModel.setProperty(0, "foo", 3);
            compare(map0.foo, 3);

            testModel.insert(1, {foo: 4, bar: "d"});
            compare(map0.foo, 3);
            compare(map1.foo, 4);
            compare(map2.foo, 1);
            compare(map3.foo, 2);

            testModel.remove(2);
            compare(map0.foo, 3);
            compare(map1.foo, 4);
            compare(map2.foo, 2);
            compare(map3.foo, undefined);

            map0.foo = 51;
            compare(testModel.get(0).foo, 51);
        }
    }
}
