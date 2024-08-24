CREATE MIGRATION m167qhnxpc5lo5ibovspwfbuuu6iksyet7oiseja24anhurt3tcl6q
    ONTO initial
{
  CREATE SCALAR TYPE default::Category EXTENDING enum<GraphicDesign, MotionDesign, ThreeDArt, PhotoVideo, WebDesign>;
  CREATE SCALAR TYPE default::ListingType EXTENDING enum<Gig, Offer>;
  CREATE TYPE default::Listing {
      CREATE REQUIRED PROPERTY categories: array<default::Category> {
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY listing_type: default::ListingType {
          SET readonly := true;
      };
      CREATE INDEX ON ((.listing_type, .created_at));
      CREATE PROPERTY description: std::str {
          SET readonly := true;
      };
      CREATE PROPERTY image_links: array<std::str> {
          CREATE CONSTRAINT std::expression ON ((std::len(__subject__) <= 4)) {
              SET errmessage := 'Only up to 4 image links allowed';
          };
      };
      CREATE REQUIRED PROPERTY pills: tuple<usdc: std::bigint, eth: std::bigint, send: std::bigint> {
          CREATE CONSTRAINT std::expression ON ((((.usdc > 0n) OR (.eth > 0n)) OR (.send > 0n))) {
              SET errmessage := 'At least one pill value must be greater than 0';
          };
      };
      CREATE REQUIRED PROPERTY title: std::str {
          SET readonly := true;
      };
  };
  CREATE TYPE default::Profile {
      CREATE PROPERTY categories: array<default::Category>;
      CREATE REQUIRED PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY sendid: std::int64 {
          SET readonly := true;
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE INDEX ON ((.sendid, .categories, .created_at));
      CREATE PROPERTY bio: std::str;
      CREATE PROPERTY hearts: std::int64;
      CREATE REQUIRED PROPERTY pills: tuple<usdc: std::bigint, eth: std::bigint, send: std::bigint> {
          CREATE CONSTRAINT std::expression ON ((((.usdc > 0n) OR (.eth > 0n)) OR (.send > 0n))) {
              SET errmessage := 'At least one pill value must be greater than 0';
          };
      };
      CREATE PROPERTY portfolio_link: std::str;
      CREATE REQUIRED PROPERTY socials: tuple<x: std::str, telegram: std::str>;
  };
  ALTER TYPE default::Listing {
      CREATE REQUIRED LINK creator: default::Profile {
          SET readonly := true;
      };
  };
  ALTER TYPE default::Profile {
      CREATE MULTI LINK listings := (.<creator[IS default::Listing]);
  };
  CREATE TYPE default::Skill {
      CREATE REQUIRED PROPERTY name: std::str {
          SET readonly := true;
      };
      CREATE PROPERTY title_name := (std::str_title(.name));
      CREATE CONSTRAINT std::exclusive ON (.title_name);
  };
  ALTER TYPE default::Listing {
      CREATE MULTI LINK skills: default::Skill;
  };
  ALTER TYPE default::Profile {
      CREATE MULTI LINK skills: default::Skill;
  };
  CREATE SCALAR TYPE default::SupportedChainId EXTENDING std::int32 {
      CREATE CONSTRAINT std::one_of(1, 8453, 84532);
  };
  CREATE TYPE default::Session {
      CREATE REQUIRED PROPERTY expires_at: std::datetime {
          SET default := ((std::datetime_current() + <std::duration>'5 minutes'));
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY key: std::str {
          SET readonly := true;
          CREATE CONSTRAINT std::max_len_value(43);
          CREATE CONSTRAINT std::min_len_value(43);
          CREATE ANNOTATION std::description := 'A jwk thumbprint anonymously connecting the user to a device or agent';
      };
      CREATE INDEX ON ((.key, .expires_at));
      CREATE PROPERTY about: std::str {
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY address: std::str {
          SET readonly := true;
          CREATE ANNOTATION std::description := 'The ethereum address associated with the send account';
          CREATE CONSTRAINT std::max_len_value(42);
          CREATE CONSTRAINT std::min_len_value(42);
      };
      CREATE PROPERTY avatar_url: std::str {
          SET readonly := true;
      };
      CREATE PROPERTY chain_id: default::SupportedChainId {
          SET default := 8453;
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY confirmation_address: std::str {
          SET readonly := true;
          CREATE ANNOTATION std::description := 'An ethereum address that will receive the confirmation tx';
          CREATE CONSTRAINT std::max_len_value(42);
          CREATE CONSTRAINT std::min_len_value(42);
      };
      CREATE PROPERTY confirmation_amount: std::bigint {
          SET default := 0n;
          SET readonly := true;
          CREATE ANNOTATION std::description := 'The minumum amount of tokens to send to the confirmation address';
          CREATE CONSTRAINT std::min_value(0);
      };
      CREATE REQUIRED PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
      CREATE TRIGGER prune_session
          AFTER INSERT 
          FOR EACH DO (DELETE
              default::Session
          FILTER
              ((.expires_at < std::datetime_current()) OR (.key = __new__.key))
          );
      CREATE PROPERTY refcode: std::str {
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY sendid: std::int64 {
          SET readonly := true;
      };
      CREATE PROPERTY sendtag: std::str {
          SET readonly := true;
      };
  };
};
