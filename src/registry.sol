pragma solidity ^0.5.3;

import 'tinlake-auth/auth.sol';
import 'tinlake-math/math.sol';

contract PushRegistry is Auth {

    // --- Data ---
    mapping (uint => uint) public data;

    constructor () public {
        wards[msg.sender] = 1;
    }

    // --- List ---
    function update(uint what, uint value) internal {
      data[what] = value;
    }


    function get(uint what) public view returns(uint) {
         return data[what];
    }

    function set(uint what, uint value) public auth {
      update(what, value);
    }
}

contract SumPushRegistry is Auth, Math {
    // --- Data ---
    mapping (uint => uint) public data;
    uint public                   sum;

    constructor () public {
        wards[msg.sender] = 1;
    }

    // --- List ---
    function update(uint what, uint value) internal {
        if (value < data[what]) {
            sum = safeSub(sum, safeSub(data[what], value));
        } else {
            sum = safeAdd(sum, safeSub(value, data[what]));
        }
        data[what] = value;
    }

    function get(uint what) public view returns(uint) {
         return data[what];
    }

    function set(uint what, uint value) public auth {
      update(what, value);
    }
}
