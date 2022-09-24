// SPDX-Liences-Identifier: MIT;
pragma solidity >=0.7.0 <0.9.0;

contract Monring {
  struct MyStruct {
    uint foo;
    string text;
  }

  mapping(address => MyStruct) public myStructs;

  function examples() external returns (string memory) {
    myStructs[msg.sender] = MyStruct({ foo: 123, text: "bar"});

    
    // Storage => State can be read or change the values
    MyStruct storage myStruct = myStructs[msg.sender];
    myStruct.text = "foo";
    myStruct.foo = 21;

    MyStruct memory readOnly = myStructs[msg.sender];
    readOnly.foo = 456;
     
  }
}
