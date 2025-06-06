// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/SwapApp.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract SwapAppTest is Test {
    SwapApp app;
    address uniswapV2Router02 = 0x4752ba5DBc23f44D87826276BF6Fd6b1C372aD24;
    address USDT = 0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9;
    address USDC = 0xaf88d065e77c8cC2239327C5EDb3A432268e5831;
    address user = 0xF977814e90dA44bFA03b6295A0616a897441aceC;

    function setUp() public {
        app = new SwapApp(uniswapV2Router02);
    }

    function testDeployedCorrectly() public view {
        assertEq(uniswapV2Router02, app.V2Router02());
    }

    function testSwap() public {
        vm.startPrank(user);

        uint amountIn = 100 * 1e6;
        uint amountOutMin = 99 * 1e6;
        uint deadline = block.timestamp + 1200000;
        IERC20(USDT).approve(address(app), amountIn);
        address[] memory path = new address[](2);
        path[0] = USDT;
        path[1] = USDC;

        uint usdtBalanceBefore = IERC20(USDT).balanceOf(user);
        uint usdcBalanceBefore = IERC20(USDC).balanceOf(user);

        app.swapTokens(amountIn, amountOutMin, path, deadline);

        uint usdtBalanceAfter = IERC20(USDT).balanceOf(user);
        uint usdcBalanceAfter = IERC20(USDC).balanceOf(user);

        assertEq(usdtBalanceAfter, usdtBalanceBefore - amountIn);
        assert(usdcBalanceAfter > usdcBalanceBefore + amountOutMin - 1);
    }
}
