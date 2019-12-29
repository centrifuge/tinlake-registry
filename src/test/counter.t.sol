pragma solidity ^0.5.12;

import "ds-test/test.sol";

import "../counter.sol";

contract CounterTest is DSTest {
    Counter counter ;

    function setUp() public {
        counter = new Counter();
    }

    function test_counter() public {
        assertEq(counter.sum(), 0);
        assertEq(counter.get(0), 0);
        counter.inc(0);
        assertEq(counter.sum(), 1);
        assertEq(counter.get(0), 1);
        counter.inc(0);
        counter.inc(0);
        counter.inc(1);
        assertEq(counter.sum(), 4);
        assertEq(counter.get(0), 3);
        assertEq(counter.get(1), 1);
    }
}
