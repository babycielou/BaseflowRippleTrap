// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RippleSignalCaster {
    event RippleSignal(uint256 baseFee, uint256 blockNumber);

    function castRipple(uint256 baseFee, uint256 blockNumber) external {
        emit RippleSignal(baseFee, blockNumber);
    }
}
