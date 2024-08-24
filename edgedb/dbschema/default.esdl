module default {
  scalar type Category extending enum<GraphicDesign, MotionDesign, ThreeDArt, PhotoVideo, WebDesign>;
  scalar type ListingType extending enum<Gig, Offer>;

  type Skill {
    required name -> str{
      readonly := true;
    }
    title_name := str_title(.name);
    constraint exclusive on (.title_name);
  }

  type Profile {
    required sendid -> int64 {
      constraint exclusive;
      readonly := true;
    };
    required socials -> tuple<x : str, telegram:str>;
    required pills: tuple<usdc: bigint, eth: bigint, send: bigint> {
      constraint expression on (
        .usdc > 0n
        or .eth > 0n
        or .send > 0n
      ){errmessage := 'At least one pill value must be greater than 0'}
    };
    bio -> str;
    portfolio_link -> str;
    categories -> array<Category>;
    hearts -> int64;
    required created_at -> datetime {
      readonly := true;
      default := datetime_current();
    };
    multi skills: Skill;
    multi listings := (.<creator[is Listing]);
    index on ((.sendid, .categories, .created_at));
  }

  type Listing {
    required creator -> Profile {
      readonly := true;
    };
    required listing_type -> ListingType{
      readonly := true;
    };
    required categories -> array<Category>{
      readonly := true;
    };
    required title -> str{
      readonly := true;
    };
    description -> str{
      readonly := true;
    }
    required pills: tuple<usdc: bigint, eth: bigint, send: bigint> {
      constraint expression on (
        .usdc > 0n
        or .eth > 0n
        or .send > 0n
      ){errmessage := 'At least one pill value must be greater than 0'}
    };
    image_links -> array<str>{
      constraint expression on (len(__subject__) <= 4){errmessage:= "Only up to 4 image links allowed"};
    };
    required created_at -> datetime {
      readonly := true;
      default := datetime_current();
    };

    multi skills: Skill;

    index on ((.listing_type, .created_at));
  }
}