module default {
  scalar type ListingCategory extending enum<GraphicDesign, MotionDesign, ThreeDArt, PhotoVideo, WebDesign>;
  scalar type ListingType extending enum<Gig, Offer>;
  scalar type Token extending enum<USDC, ETH, SEND>;

  type Fee {
    required amount -> bigint {
      constraint min_value(1n);
    }
    required token -> Token;
  }

  type Tag {
    required name -> str;
  }

  type Listing {
    required sendid -> int64 {
      readonly := true;
    };
    required listing_type -> ListingType;
    required title -> str;
    description -> str;
    required multi fees -> Fee ; # TODO: should be constrained to be unique and max of 3
    multi contact_fees -> Fee; # TODO: should be constrained to be unique and max of 3
    image_links -> array<str>;
    required contact_links -> array<str>;

    multi tags: Tag;

    index on ((.sendid, .listing_type));
  }
}
