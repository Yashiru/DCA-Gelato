// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

interface IOps {
    function gelato() external view returns (address payable);

    function createTaskNoPrepayment(
        address _execAddress,
        bytes4 _execSelector,
        address _resolverAddress,
        bytes calldata _resolverData,
        address _tokenFee
    ) external returns (bytes32 task);

    function getFeeDetails() external returns(uint256, address);
}
