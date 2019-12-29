pragma solidity ^0.5.12;

import "ds-test/test.sol";

import "./Registry.sol";

contract RegistryTest is DSTest {
    Registry registry;

    function setUp() public {
        registry = new Registry();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
