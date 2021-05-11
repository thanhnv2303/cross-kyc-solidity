pragma solidity 0.6.12;

contract Addresser {
    function getVerifyAddress(bytes memory publicKey) public pure returns (address) {
        return address(uint(keccak256(publicKey)) & 0x00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF);
    }
}
