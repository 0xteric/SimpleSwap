# SwapApp Smart Contract

This contract allows users to swap ERC20 tokens via a Uniswap V2 compatible router.

---

## ⚙️ Features

- Swap exact amounts of input tokens for output tokens
- Uses SafeERC20 for secure token transfers and approvals
- Emits events on each swap for easy tracking

---

## 📝 Key Functions

- `swapTokens(uint amountIn, uint amountOutMin, address[] calldata path, uint deadline)`
  - Transfers `amountIn` of the first token in `path` from user to contract
  - Approves the Uniswap V2 router to spend tokens
  - Calls the router's `swapExactTokensForTokens` function to swap tokens
  - Sends swapped tokens directly to the user
  - Emits `Swap` event with details of the swap

---

## 📢 Events

- `Swap(address tokenIn, address tokenOut, uint amountIn, uint amountOut)`

---

## ⚠️ Requirements

- User must approve this contract to spend `amountIn` of the input token before calling `swapTokens`

---

## 📄 License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
