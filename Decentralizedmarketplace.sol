// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
 contract DecentralizedMarketplace {

   struct item{
    uint itemId;
    string description;
    uint price;
    address payable sellerAddress;
    bool availabilityStatus;
   }
  
  mapping(string=>item) public items;
  uint nextitemId=1;


 function listItems(string calldata _name, string calldata _description, uint _price) public {
   items[_name]=item({
       itemId:nextitemId,
       description:_description,
       price:_price,
       sellerAddress:payable (msg.sender),
       availabilityStatus:true
   });
   nextitemId++;
 }

 function placeorder(string memory _itemName, uint _amount) public payable  {
    require(items[_itemName].availabilityStatus==true,"Sorry but the Item is not available for sale at the moment");
       require(_amount==msg.value,"Sent ether must be equal to item price");
  Confirm(_itemName, _amount);
 }

 function Confirm(string memory _itemName,uint _amount)internal  returns (string memory){
   if(_amount == items[_itemName].price){
    items[_itemName].sellerAddress.transfer(_amount);
   }
   items[_itemName].availabilityStatus=false;
   return "Order Confirmed";
 }
 
 function itemInfo(string memory _itemName) public view returns(uint,string memory,uint, address,bool) {
  item memory Item = items[_itemName];
  return (Item.itemId,Item.description,Item.price,Item.sellerAddress,Item.availabilityStatus);
 }

 }