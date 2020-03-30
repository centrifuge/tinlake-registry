pragma solidity >=0.5.15 <0.6.0;

import './registry.sol';

// Implements a simple counter as an example
contract Counter is SumPushRegistry {
    function inc(uint what) public {
        uint value = data[what]+1;
        update(what, value);
    }
}
