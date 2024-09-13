// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Define your ERC20 token contract
contract HelloScroll is ERC20 {
    // Constructor that mints the initial supply to the deployer of the contract
    constructor(uint256 initialSupply) ERC20("HelloScroll", "HLS"){
        // Mint the initial supply of tokens to the deployer's address
        _mint(msg.sender, initialSupply);
    }

    // Function to mint new tokens to a specified address
    function mint(address to, uint256 amount) external {
        require(to != address(0), "ERC20: mint to the zero address");
        _mint(to, amount);
    }

    // Function to burn tokens from a specified address
    function burn(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "ERC20: burn amount exceeds balance");
        _burn(msg.sender, amount);
    }

    // Function to transfer tokens from the caller's address to a specified address
    function transfer(address to, uint256 amount) public override returns (bool) {
        require(to != address(0), "ERC20: transfer to the zero address");
        _transfer(_msgSender(), to, amount);
        return true;
    }

    // Function to approve an address to spend a certain amount of tokens on behalf of the caller
    function approve(address spender, uint256 amount) public override returns (bool) {
        require(spender != address(0), "ERC20: approve to the zero address");
        _approve(_msgSender(), spender, amount);
        return true;
    }

    // Function to transfer tokens from one address to another using an allowance
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        uint256 currentAllowance = allowance(from, _msgSender());
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");

        _transfer(from, to, amount);
        _approve(from, _msgSender(), currentAllowance - amount);
        return true;
    }

    // Function to get the balance of a specific address
    function getBalanceOf(address account) external view returns (uint256) {
        return balanceOf(account);
    }
}