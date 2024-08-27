// @sourceHash 2cfb28cbecfbc197544868c0363da935

module MakeListing = {
  let queryText = `# @name makeListing
    with NewListing := (insert Listing {
      creator := (select Profile filter .id = <uuid>$creator),
      title := <str>$title,
      description := <optional str>$description,
      image_links := <optional array<str>>$imageLinks,
      listing_type := <ListingType>$listingType,
      pills := <tuple<usdc: bigint, eth: bigint, send: bigint>>$pills,
      categories := <array<Category>>$categories,
      skills := (with
                raw_data := <optional json>$skillData,
              for item in json_array_unpack(raw_data) union (
                insert Skill { name := <str>item['name'] }
              )),
      }) select NewListing {*, creator, skills:{id, title_name}}`
  
  @live  
  type args__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  @live  
  type args = {
    creator: string,
    title: string,
    description?: Null.t<string>,
    imageLinks?: Null.t<array<string>>,
    listingType: [#Gig | #Offer],
    pills: args__pills,
    categories: array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>,
    skillData?: Null.t<JSON.t>,
  }
  
  type response__creator = {
    id: string,
  }
  
  type response__skills = {
    id: string,
    title_name: string,
  }
  
  type response__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response = {
    creator: response__creator,
    skills: array<response__skills>,
    title: string,
    pills: response__pills,
    image_links: Null.t<array<string>>,
    description: Null.t<string>,
    listing_type: [#Gig | #Offer],
    created_at: Date.t,
    categories: array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>,
    id: string,
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