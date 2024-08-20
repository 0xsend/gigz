// @sourceHash 67c6f1c4cbd0342ef3aca1bd036b523f

module MakeListing = {
  let queryText = `# @name makeListing
    with NewListing := (insert Listing {
      title := <str>$title,
      sendid := <int64>$sendid,
      description := <optional str>$description,
      contact_links := <array<str>>$contactLinks,
      image_links := <optional array<str>>$imageLinks,
      listing_type := <ListingType>$listingType,
      fees := (with raw_data :=<json>$feeData,
              for item in json_array_unpack(raw_data) union (
                insert Fee { amount := <bigint>item['amount'], token := <Token>item['token'] }
              )),
      tags := (with
                raw_data := <optional json>$tagData,
              for item in json_array_unpack(raw_data) union (
                insert Tag { name := <str>item['name'] }
              )),
      contact_fees := (with
                raw_data := <optional json>$contactFeeData,
              for item in json_array_unpack(raw_data) union (
                insert Fee { amount := <bigint>item['amount'], token := <Token>item['token'] }
              ))
  
      }) select NewListing {**}`
  
  @live  
  type args = {
    title: string,
    sendid: float,
    description?: Null.t<string>,
    contactLinks: array<string>,
    imageLinks?: Null.t<array<string>>,
    listingType: [#Gig | #Offer],
    feeData: JSON.t,
    tagData?: Null.t<JSON.t>,
    contactFeeData?: Null.t<JSON.t>,
  }
  
  type response__tags = {
    id: string,
    name: string,
  }
  
  type response__fees = {
    id: string,
    amount: bigint,
    token: [#USDC | #ETH | #SEND],
  }
  
  type response__contact_fees = {
    id: string,
    amount: bigint,
    token: [#USDC | #ETH | #SEND],
  }
  
  type response = {
    created_at: Date.t,
    title: string,
    image_links: Null.t<array<string>>,
    description: Null.t<string>,
    contact_links: array<string>,
    sendid: float,
    listing_type: [#Gig | #Offer],
    id: string,
    tags: array<response__tags>,
    fees: array<response__fees>,
    contact_fees: array<response__contact_fees>,
  }
  
  @live
  let query = (client: EdgeDB.Client.t, args: args): promise<result<response, EdgeDB.Error.errorFromOperation>> => {
    client->EdgeDB.QueryHelpers.singleRequired(queryText, ~args)
  }
  
  @live
  let transaction = (transaction: EdgeDB.Transaction.t, args: args): promise<result<response, EdgeDB.Error.errorFromOperation>> => {
    transaction->EdgeDB.TransactionHelpers.singleRequired(queryText, ~args)
  }
}