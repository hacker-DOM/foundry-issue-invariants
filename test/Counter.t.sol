// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    uint256 public numInvariantsRun; // = 0

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function setNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function invariant_NumberIsNonNegative() public {
        numInvariantsRun++;
        console.log("Invariant check number:", numInvariantsRun);
        assertGe(counter.number(), 0, "Counter number should be non-negative");
    }
}
