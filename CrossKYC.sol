pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

contract CrossKYC {
    struct Account {
        int64 chainId;
        bytes publicKey;
    }

    mapping(int32 => Account) accounts;
    int32 num = 0;

    function sameAs(
        int32 number,
        int64[] memory chainId,
        string[] memory publicKey,
        string[] memory signatures,
        int64 timestamp
    ) public {
        // verify signatures and accounts
        // save account into  account
        // require(chainId.length == number);
        // require(publicKey.length == number);
        // require(chainId.length == number);
        // require(verifyTimestamp(timestamp));

        for (uint256 i = 0; i < uint256(number); i++) {
            accounts[num] = Account(
                chainId[i],
                stringToBytesArray(publicKey[i])
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

    function hasAccount(bytes memory publicKey) public  returns (bool) {
        
        for (uint256 i = 0; i < uint256(num); i++) {
            string memory pub =  string(accounts[int32(i)].publicKey);
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

    // to verify timestamp
    function verifyTimestamp(int64 timestamp) public returns (bool valid) {
        return true;
    }

    /* bytes to string */
    function bytesArrayToString(bytes memory _bytes)
        public
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


