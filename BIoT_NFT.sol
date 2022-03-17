// SPDX-License-Identifier: GPL-3.0
//https://remix.ethereum.org/
pragma solidity >=0.8.0 <0.9.0;
import "https://github.com/josesanchez2019/SmartContracts_BIoT/blob/main/erc721-master/src/contracts/tokens/nf-token-metadata.sol";
import "https://github.com/josesanchez2019/SmartContracts_BIoT/blob/main/erc721-master/src/contracts/ownership/ownable.sol";

contract IoT is NFTokenMetadata, Ownable{

    constructor() {
        nftName = "IoT Blockchain";
        nftSymbol = "BIoT";
    }

    function mint(address _to, uint256 _tokenId, string calldata _uri) external onlyOwner {
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _uri);
    }

    struct msg_iot {
        string message;
        uint256 timestamp;
    }

   /* event Message (
        address indexed sender,
        string message,
        uint256 timestamp,
        uint256 tokenId
    );*/

    mapping(uint256 => msg_iot) public getTopicMessage;
    msg_iot private message_struct;
    
    function addMessage(string memory _message, uint256 _tokenId) public {
        require(msg.sender == super.ownerOf(_tokenId));
        message_struct = msg_iot(_message, block.timestamp);
        //emit Message(msg.sender, _message, block.timestamp, _tokenId);
        getTopicMessage[_tokenId] = message_struct;
    }
    
}
