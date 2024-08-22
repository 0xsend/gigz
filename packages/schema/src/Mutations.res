open Listing
%%raw("import 'json-bigint-patch'")

let makeListing = %edgeql(`
  # @name makeListing
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

    }) select NewListing {**}
  `)

module FeeInput = {
  @gql.inputObject
  type feeInput = {amount: Schema.BigInt.t, token: token}
}

@gql.inputObject type tagInput = {name: string}

@gql.inputObject
type makeListing = {
  /** The sendid to request a session for*/
  sendid: float,
  /** The title of the listing */
  title: string,
  /** The description of the listing */
  description?: string,
  /** The chain id to use for the session */
  contactLinks: array<string>,
  /** The chain id to use for the session */
  imageLinks?: array<string>,
  /** The fees for the listing */
  fees: array<FeeInput.feeInput>,
  /** The tags for the listing */
  tags?: array<tagInput>,
  /** The fees to contact the lister */
  contactFees?: array<FeeInput.feeInput>,
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
    sendid: input.sendid,
    description: input.description->Null.fromOption,
    contactLinks: input.contactLinks,
    imageLinks: input.imageLinks->Null.fromOption,
    listingType: listingType->ListingType.castToDb,
    feeData: input.fees
    ->Array.map(fee => {"amount": fee.amount, "token": Token.castToDb(fee.token)})
    ->JSON.stringifyAny
    ->Option.getOr("[]")
    ->JSON.parseExn,
    tagData: switch input.tags
    ->JSON.stringifyAny
    ->Option.getOr("[]")
    ->JSON.parseExn {
    | exception _ => Null.null
    | data => Null.Value(data)
    },
    contactFeeData: switch input.contactFees
    ->Array.map(fee => {"amount": fee.amount, "token": Token.castToDb(fee.token)})
    ->JSON.stringifyAny
    ->Option.getOr("[]")
    ->JSON.parseExn {
    | exception _ => Null.null
    | data => Null.Value(data)
    },
  }) {
  | Ok(listing) =>
    Ok({newListing: Listing.castToResgraph((listing :> Listing__edgeql.One.response))})
  | Error(edgeDbError) =>
    switch edgeDbError {
    | EdgeDbError({code: ConstraintViolationError}) =>
      Error({name: "Constraint Violation Error", reason: "One of the inputs was invalid"})
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
