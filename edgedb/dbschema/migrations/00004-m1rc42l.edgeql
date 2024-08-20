CREATE MIGRATION m1rc42lnxmhbd5rvpdhcgihk3gq5vee7czhdbpjhpjw3auctsxlrhq
    ONTO m1twtfngumxghaebesx3aqs25k33whdtal5pbbdvv5bg56xtxdf2ha
{
  DROP GLOBAL default::admins;
  CREATE SCALAR TYPE default::Token EXTENDING enum<USDC, ETH, SEND>;
  CREATE TYPE default::Fee {
      CREATE REQUIRED PROPERTY amount: std::bigint {
          CREATE CONSTRAINT std::min_value(1n);
      };
      CREATE REQUIRED PROPERTY token: default::Token;
  };
  CREATE TYPE default::Tag {
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE SCALAR TYPE default::ListingType EXTENDING enum<Gig, Offer>;
  CREATE TYPE default::Listing {
      CREATE MULTI LINK contact_fees: default::Fee;
      CREATE REQUIRED MULTI LINK fees: default::Fee;
      CREATE REQUIRED PROPERTY listing_type: default::ListingType;
      CREATE REQUIRED PROPERTY sendid: std::int64 {
          SET readonly := true;
      };
      CREATE INDEX ON ((.sendid, .listing_type));
      CREATE MULTI LINK tags: default::Tag;
      CREATE REQUIRED PROPERTY contact_links: array<std::str>;
      CREATE PROPERTY description: std::str;
      CREATE PROPERTY image_links: array<std::str>;
      CREATE REQUIRED PROPERTY title: std::str;
  };
  DROP TYPE default::Gig;
  DROP SCALAR TYPE default::GigType;
  CREATE SCALAR TYPE default::ListingCategory EXTENDING enum<GraphicDesign, MotionDesign, ThreeDArt, PhotoVideo, WebDesign>;
};
