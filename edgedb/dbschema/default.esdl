module default {
  scalar type ListingCategory extending enum<GraphicDesign, MotionDesign, ThreeDArt, PhotoVideo, WebDesign>;
  scalar type ListingType extending enum<Gig, Offer>;

  type Skill {
    required name -> str;
  }

  type Listing {
    required sendid -> int64 {
      readonly := true;
    };
    required listing_type -> ListingType{
      readonly := true;
    };
    required title -> str{
      readonly := true;
    };
    description -> str{
      readonly := true;
    }
    required pills: tuple<usdc: bigint, eth: bigint, send: bigint>{
      readonly := true;
      constraint expression on (
        __subject__.usdc > 0n
        or __subject__.eth > 0n
        or __subject__.send > 0n
      ){errmessage := 'At least one pill value must be greater than 0'}
    }
    image_links -> array<str>{
      constraint expression on (len(__subject__) <= 4){errmessage:= "Only up to 4 image links allowed"};
    };
    required created_at -> datetime {
      readonly := true;
      default := datetime_current();
    };

    multi skills: Skill;

    index on ((.sendid, .listing_type));
  }
}
