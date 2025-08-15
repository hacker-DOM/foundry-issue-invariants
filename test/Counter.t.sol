// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract Handler {
    Counter public counter;
    uint256 public numInvariantsRun; // = 0

    constructor() {
        counter = new Counter();
    }

    function setNumber(uint256 x) public {
        counter.setNumber(x);
    }

    function incrementNumInvariantsRun() public {
        numInvariantsRun++;
    }
}

contract CounterTest is Test {

    Handler public handler;

    function setUp() public {
        handler = new Handler();

        bytes4[] memory selectors = new bytes4[](1);
        selectors[0] = Handler.setNumber.selector;

        targetSelector(FuzzSelector({
            addr: address(handler),
            selectors: selectors
        }));
    }

    function invariant_NumberIsNonNegative() public {
        handler.incrementNumInvariantsRun();
        uint256 numInvariantsRun = handler.numInvariantsRun();
        string memory output = vm.toString(numInvariantsRun);
        vm.writeLine("output-write-line.txt", output);
        assertGe(handler.counter().number(), 0, "Counter number should be non-negative");
    }
}
