// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "./interfaces/IV2Router02.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

contract SwapApp {
    using SafeERC20 for IERC20;
    address public V2Router02;

    event Swap(address tokenIn, address tokenOut, uint amountIn, uint amountOut);

    constructor(address _V2router02) {
        V2Router02 = _V2router02;
    }

    function swapTokens(uint amountIn, uint amountOutMin, address[] calldata path, uint deadline) external {
        IERC20(path[0]).safeTransferFrom(msg.sender, address(this), amountIn);
        IERC20(path[0]).approve(V2Router02, amountIn);
        uint[] memory amounts = IV2Router02(V2Router02).swapExactTokensForTokens(amountIn, amountOutMin, path, msg.sender, deadline);

        emit Swap(path[0], path[path.length - 1], amountIn, amounts[amounts.length - 1]);
    }
}
