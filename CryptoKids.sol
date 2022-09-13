// SPDX-License-Identifier: GPL-3.

pragma solidity ^0.8.7;

contract CrytoKids {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    struct Kid {
        address payable walletAddress;
        string firstName;
        string lastName;
        uint releaseTime;
        uint amount;
        bool canWithDraw;
      }

      Kid[] public kids;

      function addKid(address payable walletAddress, string memory firstName, string memory lasteName, uint releaseTime, uint amount, bool canWithDraw) public {
          kids.push(Kid(
            walletAddress,
            firstName,
            lasteName,
            releaseTime,
            amount,
            canWithDraw
          ));
        }

        function balaceOf() public view returns(uint) {
            return address(this).balance;
        }

        function deposit(address walletAddress) payable public {
          addToKidsBalance(walletAddress);
        }

        function addToKidsBalance(address walletAddress) private {
            for (uint i = 0; i < kids.length; i++)   {
                if (kids[i].walletAddress == walletAddress) {
                    kids[i].amount = msg.value;
                }
              }
          }

        function getIndex(address walletAddress) view private returns(uint) {
          for (uint i = 0; i < kids.length; i++) {
              if (kids[i].walletAddress == walletAddress) {
                  return i;
                }
            }

            return 999;
        }

        function availableToWithDraw(address walletAddress) public returns (bool) {
          uint i = getIndex(walletAddress);
          require(block.timestamp > kids[i].releaseTime, "You cannot withdraw yet");
          // current time > expected time
          if (block.timestamp < kids[i].releaseTime) {
            kids[i].canWithDraw = true;
            return true;
          } else if (block.timestamp < kids[i].releaseTime) {
            return false;
          }

          return false;
        }

        function withDraw(address walletAddress) payable public {
          uint i = getIndex(walletAddress);
          require(walletAddress == kids[i].walletAddress, "You must be the kid to withdraw");

          if (availableToWithDraw(walletAddress)) {
            kids[i].walletAddress.transfer(kids[i].amount);
          } 
        }
}
