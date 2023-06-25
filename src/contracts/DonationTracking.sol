pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DonationTracking is ERC721 {
    uint256 public nextTokenId;
    mapping (address => bool) public minters;

    constructor(address _minter) ERC721("CABEMAR Donation Tracking", "CABEMARDONATION") {
        // Define o endereço que pode mintar (emitir) tokens
        // Sets the address that can mint tokens
        minters[_minter] = true;
    }

    // Função que a ONG utiliza para registrar uma doação
    // Function that the NGO uses to record a donation
    function donate() public returns (uint256) {
        require(minters[msg.sender] == true, "Only minters can mint tokens");
        _mint(msg.sender, nextTokenId);
        return nextTokenId++;
    }

    // Função que a ONG utiliza para transferir a posse de um token para a fábrica de tapetes
    // Function that the NGO uses to transfer ownership of a token to the carpet factory
    function transferToFactory(address factoryAddress, uint256 tokenId) public {
        // Requer que o remetente seja o proprietário atual do token
        // Requires that the sender is the current owner of the token
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: transfer caller is not owner nor approved");
        // Transfere a posse do token
        // Transfers ownership of the token
        _transfer(msg.sender, factoryAddress, tokenId);
    }
}
