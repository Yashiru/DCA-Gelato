// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "forge-std/Test.sol";
import "../src/DcaFactory.sol";

contract ContractTest is Test {
    DcaFactory factory;


    function setUp() public {
        factory = new DcaFactory(
            0x8c089073A9594a4FB03Fa99feee3effF0e2Bc58a,
            payable(0x0630d1b8C2df3F0a68Df578D02075027a6397173)
        );
    }

    function testCreateDcaPosition() public {
        factory.startTask();
    }
}
