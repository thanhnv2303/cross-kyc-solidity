pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;
import  './VerifySignatureCrossKYC.sol'
import './Addresser.sol' 

contract CrossKYC {
    struct Account {
        int64 chainId;
        bytes publicKey;
    }

    Addresser public addresser;
    VerifySignatureCrossKYC public verifySignatureCrossKYC;

    mapping(int32 => Account) accounts;
    int32 num = 0;

    constructor(address proxyCossKYC) public {
        bytes memory payload =
            abi.encodeWithSignature("addIdentify(address)", address(this));
        (bool success, bytes memory returnData) =
            address(proxyCossKYC).call(payload);
        require(success);

        addresser = new Addresser();
        verifySignatureCrossKYC = new VerifySignatureCrossKYC()
    }

    function sameAs(
        int32 number,
        int64[] memory chainIds,
        string[] memory publicKeys,
        string[] memory signatures,
        int64 timestamp
    ) public {
        // verify signatures and accounts
        require(num < 1);
        validateBasic(number, chainIds, publicKeys, signatures, timestamp);

        //verify signature
        bytes32 hashMessage = createMessageToSign(number, chainIds, publicKeys);
        for (uint256 i = 0; i < uint256(number); i++) {
            require(
                verifySignature(
                    chainIds[i],
                    publicKeys[i],
                    signatures[i],
                    hashMessage
                )
            );
        }

        // save account into  accounts
        for (uint256 i = 0; i < uint256(number); i++) {
            accounts[num] = Account(
                chainIds[i],
                stringToBytesArray(publicKeys[i])
            );
            num++;
        }
    }

    function addAccounts(
        int32 number,
        int64[] memory chainId,
        string[] memory publicKey,
        string[] memory signatures,
        int64 timestamp,
        string memory prePublicKey,
        string memory verifySignature
    ) public {
        // add new accounts by pass pre account in contract
    }

    function hasAccount(bytes memory publicKey) public view returns (bool) {
        for (uint256 i = 0; i < uint256(num); i++) {
            string memory pub = string(accounts[int32(i)].publicKey);
            // if (StringUtils.equal( string(publicKey),pub)) return true;
        }

        return false;
    }

    function allAccounts() public view returns (Account[] memory) {
        Account[] memory ret = new Account[](uint256(num));
        for (uint256 i = 0; i < uint256(num); i++) {
            ret[i] = accounts[int32(i)];
        }
        return ret;
    }

    function validateBasic(
        int32 number,
        int64[] memory chainIds,
        string[] memory publicKeys,
        string[] memory signatures,
        int64 timestamp
    ) public view {
        uint256 numberu256 = uint256(number);
        require(chainIds.length == numberu256);
        require(publicKeys.length == numberu256);
        require(signatures.length == numberu256);
        require(verifyTimestamp(timestamp));
    }

    // to verify timestamp
    function verifyTimestamp(int64 timestamp) public view returns (bool valid) {
        // check time commit around 1 day from commit
        require(uint256(timestamp) > now - 86400);
        return true;
    }

    function createMessageToSign(
        int32 number,
        int64[] memory chainIds,
        string[] memory publicKeys
    ) public pure returns (bytes32) {
        bytes memory message =
            meregeChainIdAndPublicKey(number, chainIds, publicKeys);
        return hashMessage(message);
    }

    function meregeChainIdAndPublicKey(
        int32 number,
        int64[] memory chainIds,
        string[] memory publicKeys
    ) public pure returns (bytes memory newAccounts) {
        for (uint256 i = 0; i < uint256(number); i++) {
            newAccounts = abi.encodePacked(
                newAccounts,
                chainIds[i],
                publicKeys[i]
            );
        }

        return newAccounts;
    }

    function hashMessage(bytes memory mergeMessage)
        public
        pure
        returns (bytes32)
    {
        return keccak256(mergeMessage);
    }

    function verifySignature(
        int64 chainId,
        string memory publicKey,
        string memory signature,
        bytes32 message
    ) public pure returns (bool) {

        address verifyAddress = adresser.getVerifyAddress(publicKey)
        return verifySignatureCrossKYC.verify(verifyAddress, message,signature);
    }

    /* bytes to string */
    function bytesArrayToString(bytes memory _bytes)
        public
        pure
        returns (string memory)
    {
        return string(_bytes);
    } //

    event BytesToString(bytes _bytes, string _string);

    /* string to bytes */
    function stringToBytesArray(string memory str)
        public
        returns (bytes memory)
    {
        return bytes(str);
    } //

    event StringToBytesArray(string _string, bytes _bytes);
}
