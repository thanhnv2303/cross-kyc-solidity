pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract CrossKYCProxy {
    mapping(uint256 => address) identities;
    uint256 num;

    constructor() public {
        num = 0;
    }

    function addIdentify(address crossKYC) public {
        identities[num] = crossKYC;
        num++;
    }

    function getCrossIdentity(address account) public view returns (address) {
        
    }

    function getAllCrossIdentity()
        public
        view
        returns (address[] memory crossIdentities)
    {
        crossIdentities = new address[](num);
        for (uint256 i = 0; i < num; i++) {
            crossIdentities[i] = identities[i];
        }
        return crossIdentities;
    }
}
