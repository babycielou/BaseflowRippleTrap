// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BaseflowRippleRelay {
    event RippleDetected(string message);

    function relayRipple(bytes calldata data) external {
        string memory msgText = abi.decode(data, (string));
        emit RippleDetected(msgText);
    }
}
