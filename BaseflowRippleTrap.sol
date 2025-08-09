// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BaseflowRippleTrap {
    uint256 private lastBaseFee;

    constructor() {
        lastBaseFee = block.basefee;
    }

    function collect() external view returns (bytes memory) {
        return abi.encode(block.basefee, block.number);
    }

    function shouldRespond(bytes calldata) external view returns (bool) {
        uint256 currentFee = block.basefee;

        // Avoid division by zero
        if (lastBaseFee == 0) {
            return false;
        }

        // Calculate percentage difference (scaled by 1000 for precision)
        uint256 diff = currentFee > lastBaseFee
            ? currentFee - lastBaseFee
            : lastBaseFee - currentFee;
        uint256 percentDiff = (diff * 1000) / lastBaseFee;

        // Trigger if change > 1% (percentDiff > 10 with scale of 1000)
        return percentDiff > 10;
    }
}
