// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface IERC5192 {
    event Locked(uint256 tokenId);
    event Unlocked(uint256 tokenId);

    function locked(uint256 tokenId) external view returns (bool);
}

contract SoulboundToken is ERC721, IERC5192 {
    address public immutable owner;
    uint256 public nextTokenId;

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the authorized contract manager");
        _;
    }

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        owner = msg.sender;
    }

    function locked(uint256 tokenId) external view override returns (bool) {
        require(_requireOwned(tokenId) != address(0), "Token ID does not exist");
        return true;
    }

    function mintSoulbound(address to) external onlyOwner returns (uint256) {
        require(to != address(0), "Cannot mint to zero address");
        
        uint256 tokenId = nextTokenId;
        nextTokenId++;

        _safeMint(to, tokenId);
        
        emit Locked(tokenId);
        return tokenId;
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override returns (address) {
        address from = _requireOwned(tokenId);
        
        if (from != address(0) && to != address(0)) {
            revert("SoulboundToken: Transfer actions are strictly prohibited");
        }
        
        return super._update(to, tokenId, auth);
    }
}
