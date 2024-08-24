CREATE MIGRATION m14cbzk6iu2gll6jya6fhglnvekhxdoxf2zlzgbzj255srwrtar5kq
    ONTO m1i5uazsjkzra66gugz6earf66wzam64unw6rcbuwyck3dukz4i4ha
{
  ALTER TYPE default::Fee {
      DROP PROPERTY amount;
      DROP PROPERTY token;
  };
  ALTER TYPE default::Listing {
      DROP LINK contact_fees;
  };
  ALTER TYPE default::Listing {
      DROP LINK fees;
  };
  DROP TYPE default::Fee;
  ALTER TYPE default::Tag RENAME TO default::Skill;
  ALTER TYPE default::Listing {
      ALTER LINK tags {
          RENAME TO skills;
      };
  };
  ALTER TYPE default::Listing {
      ALTER PROPERTY contact_links {
          SET readonly := true;
      };
      ALTER PROPERTY description {
          SET readonly := true;
      };
      ALTER PROPERTY image_links {
          CREATE CONSTRAINT std::expression ON ((std::len(__subject__) <= 4)) {
              SET errmessage := 'Only up to 4 image links allowed';
          };
      };
      ALTER PROPERTY listing_type {
          SET readonly := true;
      };
  };
  ALTER TYPE default::Listing {
      CREATE REQUIRED PROPERTY pills: tuple<usdc: std::bigint, eth: std::bigint, send: std::bigint> {
          SET readonly := true;
          SET REQUIRED USING ((
              usdc := 1n,
              eth := 0n,
              send := 0n
          ));
          CREATE CONSTRAINT std::expression ON ((((__subject__.usdc > 0n) OR (__subject__.eth > 0n)) OR (__subject__.send > 0n))) {
              SET errmessage := 'A Pill values must be greater than 0';
          };
      };
      ALTER PROPERTY title {
          SET readonly := true;
      };
  };
  DROP SCALAR TYPE default::Token;
};
