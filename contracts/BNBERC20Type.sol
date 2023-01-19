pragma solidity ^0.8.10;

contract BNBTokenERC20Type {
    uint256 public totalSupply = 1000 * 10**18;
    string public tokenName = "SUIToken";
    string public tokenSymbol = "SUI";
    uint256 public decimals = 18;

    // mappings
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowance;

    // events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address owner) public view returns (uint256) {
        return balances[owner];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(
            balanceOf(msg.sender) >= amount,
            "Low balance on sender's address"
        );

        balances[to] += amount;
        balances[msg.sender] -= amount;

        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        require(
            balanceOf(from) >= amount,
            "Sender doesn't have enough balance to make the transaction"
        );
        require(
            allowance[from][msg.sender] >= amount,
            "Allowance is low or approval hasn't been made"
        );
        balances[to] += amount;
        balances[from] -= amount;

        emit Transfer(from, to, amount);

        return true;
    }
}
