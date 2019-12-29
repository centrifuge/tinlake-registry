pragma solidity ^0.5.12;

contract PushRegistry {
    // --- Auth ---
    mapping (address => uint) public wards;
    function rely(address usr) public auth { wards[usr] = 1; }
    function deny(address usr) public auth { wards[usr] = 0; }
    modifier auth { require(wards[msg.sender] == 1); _; }


    // --- Data ---
    mapping (uint => uint) public data;

    constructor () public {
        wards[msg.sender] = 1;
    }

    // --- List ---
    function update(uint what, uint value) internal {
      data[what] = value;
    }


    function get(uint what) public returns(uint) {
         return data[what];
    }

    function set(uint what, uint value) public auth {
      update(what, value);
    }
}

contract SumPushRegistry {
    // --- Auth ---
    mapping (address => uint) public wards;
    function rely(address usr) public auth { wards[usr] = 1; }
    function deny(address usr) public auth { wards[usr] = 0; }
    modifier auth { require(wards[msg.sender] == 1); _; }


    // --- Data ---
    mapping (uint => uint) public data;
    uint public                   sum;

    constructor () public {
        wards[msg.sender] = 1;
    }


    // --- Math ---
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x);
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x);
    }

    // --- List ---
    function update(uint what, uint value) internal {
        if (value < data[what]) {
            sum = sub(sum, (data[what] - value));
        } else {
            sum = add(sum, (value - data[what]));
        }
        data[what] = value;
    }

    function get(uint what) public returns(uint) {
         return data[what];
    }

    function set(uint what, uint value) public auth {
      update(what, value);
    }
}
