open Listing
%%raw("import 'json-bigint-patch'")

let makeListing = %edgeql(`
  # @name makeListing
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
    }) select NewListing {*, creator, skills:{id, title_name}}
  `)

@gql.inputObject
type pillsInput = {usdc: Schema.BigInt.t, eth: Schema.BigInt.t, send: Schema.BigInt.t}

@gql.inputObject type skillInput = {name: string}

@gql.inputObject
type makeListing = {
  /** The id to request a session for*/
  creator: string,
  /** The title of the listing */
  title: string,
  /** The description of the listing */
  description?: string,
  /** The chain id to use for the session */
  imageLinks?: array<string>,
  /** The payment pills for the listing */
  pills: pillsInput,
  /** The tags for the listing */
  skills?: array<skillInput>,
  /** The categories for the listing */
  categories: array<Schema.Category.category>,
}

@gql.inputUnion
type makeListingByType =
  | Offer(makeListing)
  | Gig(makeListing)

@gql.union
type makeListingResult =
  | Ok({newListing: Listing.listing})
  | Error({name: string, reason: string})


@gql.field
let makeListing = async (
  _: Schema.mutation,
  ~ctx: ResGraphContext.context,
  ~input: makeListingByType,
): makeListingResult => {
  let (listingType, input) = switch input {
  | Offer(input) => (Listing.Offer, input)
  | Gig(input) => (Listing.Gig, input)
  }
  // @todo: sendpay confirmation
  switch await ctx.edgedbClient->makeListing({
    title: input.title,
    creator: input.creator,
    description: input.description->Null.fromOption,
    imageLinks: input.imageLinks->Null.fromOption,
    listingType: listingType->ListingType.castToDb,
    pills: {
      usdc: input.pills.usdc,
      eth: input.pills.eth,
      send: input.pills.send,
    },
    categories: input.categories->Array.map(category => category->Schema.Category.castToDb),
    skillData: switch input.skills
    ->JSON.stringifyAny
    ->Option.getOr("[]")
    ->JSON.parseExn {
    | exception _ => Null.null
    | data => Null.Value(data)
    },
  }) {
  | Ok(listing) =>
    Ok({newListing: Listing.castOneToResgraph((listing :> Listing__edgeql.One.response))})
  | Error(edgeDbError) =>
    switch edgeDbError {
    | EdgeDbError({code: ConstraintViolationError}) =>
      Error({name: "Constraint Violation Error", reason: "One of the inputs was invalid"})
    | EdgeDbError({code: MissingRequiredError}) =>
      Error({name: "Missing Required Error", reason: "One of the required fields was missing"})
    | EdgeDbError(err) =>
      Console.error(err)
      Error({name: "EdgeDB Error", reason: "Failed to write to db. Check server logs."}) //@Make a helper for edgedb error codes
    | GenericError(exn) =>
      Error({
        name: exn->Exn.name->Option.getOr("Unknown Error"),
        reason: exn->Exn.message->Option.getOr(""),
      })
    }
  }
}
