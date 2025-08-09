// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITrap {
    function collect() external view returns (bytes memory);
    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory);
}

contract BaseflowRippleTrap is ITrap {
    uint256 private constant THRESHOLD_PERCENT = 1; // Порог срабатывания 1%

    function collect() external view override returns (bytes memory) {
        return abi.encode(block.basefee);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length < 2) {
            return (false, abi.encode("Not enough data"));
        }

        uint256 currentFee = abi.decode(data[0], (uint256));
        uint256 previousFee = abi.decode(data[1], (uint256));

        if (previousFee == 0) {
            return (false, abi.encode("Invalid previous fee"));
        }

        uint256 diffPercent = currentFee > previousFee
            ? ((currentFee - previousFee) * 100) / previousFee
            : ((previousFee - currentFee) * 100) / previousFee;

        if (diffPercent >= THRESHOLD_PERCENT) {
            return (true, abi.encode("Basefee ripple detected"));
        } else {
            return (false, abi.encode("No significant ripple"));
        }
    }
}
