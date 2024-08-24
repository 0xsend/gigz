CREATE MIGRATION m1jmpopwja5sv5kwwf63oz4sozntd5qhcwxsfz2bl2jh4nbqfzihha
    ONTO m14cbzk6iu2gll6jya6fhglnvekhxdoxf2zlzgbzj255srwrtar5kq
{
  ALTER TYPE default::Listing {
      DROP PROPERTY contact_links;
      ALTER PROPERTY pills {
          ALTER CONSTRAINT std::expression ON ((((__subject__.usdc > 0n) OR (__subject__.eth > 0n)) OR (__subject__.send > 0n))) {
              SET errmessage := 'At least one pill value must be greater than 0';
          };
      };
  };
};
