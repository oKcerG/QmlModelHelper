import QtQuick 2.0
import QtQml 2.2
import QtTest 1.1
import ModelHelper 0.1

Item {
    ListModel {
        id: testModel
    }
    TestCase {
        name: "RoleTest"

        property var helperRoles: testModel.ModelHelper.roles

        function compare_roles(roles) {
            //compare(JSON.stringify(helperRoles), JSON.stringify(roles));
        }

        function test_roles() {
            compare(helperRoles.length, 0);
            testModel.append({"foo": 0, "bar": "a"});
            var actualRolesString = JSON.stringify(helperRoles);
            var expectedRoles1 = JSON.stringify([{"role": 0, "roleName": "bar"}, {"role": 1, "roleName": "foo"}]);
            var expectedRoles2 = JSON.stringify([{"role": 1, "roleName": "foo"}, {"role": 0, "roleName": "bar"}]);
            verify(actualRolesString === expectedRoles1 || actualRolesString === expectedRoles2,
                   "Roles don't march, expected " + expectedRoles1 + " or " + expectedRoles2 + ", got " + actualRolesString);
        }
    }
}
