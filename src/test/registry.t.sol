pragma solidity >=0.5.15 <0.6.0;

import "ds-test/test.sol";

import "../registry.sol";

contract RegistryLike {
    function set(uint what, uint value) public;
}

contract NonPermissionUser {
    function set(address registry, uint what, uint value) public {
        RegistryLike(registry).set(what, value);
    }
}


contract RegistryTest is DSTest {
    PushRegistry pushRegistry;
    SumPushRegistry sumRegistry;

    function setUp() public {
        pushRegistry = new PushRegistry();
        sumRegistry = new SumPushRegistry();
    }

    function testSumRegistry() public {
        // init
        assertEq(sumRegistry.get(1), 0);
        sumRegistry.set(1, 12);
        assertEq(sumRegistry.get(1), 12);
        assertEq(sumRegistry.sum(), 12);

        // increase
        sumRegistry.set(1, 13);
        assertEq(sumRegistry.sum(), 13);

        // decrease
        sumRegistry.set(1, 10);
        assertEq(sumRegistry.sum(), 10);

        // two values
        sumRegistry.set(2, 10);
        assertEq(sumRegistry.sum(), 20);
    }

    function testPushRegistry() public {
        // first value
        assertEq(pushRegistry.get(1), 0);
        pushRegistry.set(1, 12);
        assertEq(pushRegistry.get(1), 12);

        // second value
        assertEq(pushRegistry.get(2), 0);
        pushRegistry.set(2, 10);
        assertEq(pushRegistry.get(2), 10);
    }

    function testFailPermissionPushRegistry() public {
        NonPermissionUser user = new NonPermissionUser();
        user.set(address(pushRegistry), 1, 12);
    }

    function testFailPermissionSumRegistry() public {
        NonPermissionUser user = new NonPermissionUser();
        user.set(address(sumRegistry), 1, 12);
    }
}
