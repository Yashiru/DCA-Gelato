// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.15;

import "./Gelato/OpsReady.sol";
import "./Gelato/interfaces/IOps.sol";

/// @notice Contract that create DCA positions by calling gelato protocol.
///         In this exemple, this contract is also the "Target contract" that
///         will be called by the deployed gelato contracts. Gelato contracts will
///         be configured to call performDca().
/// @dev This contract is NOT optimized at all, this is only for PoC purpose.
contract DcaFactory is OpsReady {
    uint256 public count;
    uint256 public lastExecuted;

    constructor(address _ops, address payable _gelato)
        OpsReady(_ops, _gelato)
    {}

    /// @notice Create a Gelato task with no prepayment
    /// @dev As this contract should be a factory, this function
    ///      Should create a taks that call an other deployed 
    ///      task contract
    function startTask() external {
        IOps(ops).createTaskNoPrepayment(
            address(this),
            this.increaseCount.selector,
            address(this),
            abi.encodeWithSelector(this.checker.selector),
            0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE
        );
    }

    /// @notice Test function that should be called by the Gelato
    ///         network.
    function increaseCount(uint256 amount) external {
        require(
            ((block.timestamp - lastExecuted) > 20),
            "Counter: increaseCount: Time not elapsed"
        );
        uint256 fee;
        address feeToken;

        (fee, feeToken) = IOps(ops).getFeeDetails();

        _transfer(fee, feeToken);
        count += amount;
        lastExecuted = block.timestamp;
    }

    /// @notice Checker function that return true when the Gelato
    ///         network must call the target function on the target
    ///         contract. 
    function checker()
        external
        view
        returns (bool canExec, bytes memory execPayload)
    {
        canExec = (block.timestamp - lastExecuted) > 20;

        execPayload = abi.encodeWithSelector(
            this.increaseCount.selector,
            uint256(1)
        );
    }

    /// @notice Withdraw fund from this contract
    function withdraw() public {
        payable(msg.sender).transfer(address(this).balance);
    }

    /// @notice Add fund to this contract
    function addFund() public payable {}
}
